#!/usr/bin/env python3
"""Build `Definitions/Def_ChapterXPromoted.lean` from the workspace body of `X`.

WHY (PIPELINE_PLAN §2.13 new-name route, Session 40)
----------------------------------------------------
`submit-definition` cannot update an existing name, and five chapter bundles were
published as *skeletons* by an early generator: `Def_ChapterCarlemanTwoStep` is
182 bytes of `noncomputable section` with no namespace at all, while every
consumer statement says `open BookProof.CarlemanTwoStep` and dies with `unknown
namespace`.  The published copies are immutable, so the declarations have to
reach the platform under a NEW bundle name that keeps the ORIGINAL namespace --
what `Def_ChapterG3Promoted` and friends already do for a single lemma.

Two constraints shape what this script emits:

  * **Definitions only.**  A declaration that is also a problem node (`thm:` item
    in `pipeline/wave_upload.json`) cannot be re-carried: the platform publishes
    a node as a declaration of the same Lean name, so the bundle and the node
    would collide (`… has already been declared`).  The two routes must partition
    the names; this bundle takes the definitions, the nodes stay theorems.
  * **Closure over cited nodes.**  A definition's *body* may cite a node lemma
    (`mem_innK`, `sum_simplex_split`, …), and there is no way to re-prove it in a
    bundle without re-carrying it.  `--carry NAME` accepts exactly those, chosen
    by the driver `debug/promote_def_closure.py`, which compiles and reads back
    the `Unknown identifier` names.

When the node/definition web is too dense to split (a lemma's body cites node
lemmas that themselves cite nodes -- `ChapterCarlemanSimplex` needs 18 of its 33
nodes before it compiles), `--whole` re-carries the ENTIRE chapter body: the
bundle then supplies the whole vocabulary, and every node whose name it carries
must be parked in the ledger, because the platform publishes a node as a
declaration of the same Lean name and the two cannot coexist.

Usage:
  python3 debug/make_promoted_def.py ChapterCarlemanTwoStep [--carry X ...]
  python3 debug/make_promoted_def.py ChapterCarlemanSimplex --whole
  # closure search: python3 debug/promote_def_closure.py ChapterCarlemanTwoStep ...
"""
import argparse
import json
import os
import re

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

HEADER = """-- §2.13 new-name route (Session 40): the platform's served `Def_{chap}` copy is a
-- skeleton (no declarations{nsnote}), so `open {ns}` in every consumer statement
-- dies with `unknown namespace`.  `submit-definition` cannot update an existing
-- name, so this bundle carries the chapter's DEFINITIONS in the original
-- namespace; its theorem facts stay problem nodes.  Consumers add a single
-- `import Definitions.Def_{chap}Promoted`.
"""

DECL = re.compile(r"(?:noncomputable\s+)?(?:private\s+)?(?:protected\s+)?"
                  r"(?:def|theorem|lemma|abbrev|structure|class|instance)\s+"
                  r"([A-Za-z_][A-Za-z0-9_.']*)")
DECL_KW = ("theorem ", "lemma ", "def ", "abbrev ", "structure ", "class ",
           "instance ", "noncomputable def ", "noncomputable theorem ",
           "noncomputable lemma ", "private ", "protected ", "@[")
TOP_KW = ("namespace ", "end", "open ", "variable ", "section", "universe ",
          "noncomputable section", "/-", "#", "attribute ", "set_option ",
          "scoped ", "local ")


def node_names(chap):
    """Lean names that `pipeline/wave_upload.json` publishes as problem nodes."""
    w = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    return {m["name"].rsplit(".", 1)[-1]
            for m in w["thms"].values()
            if m.get("chapter") == chap and m.get("name")}


def strip(body, nodes, defs_only, carry):
    """Drop theorem blocks (and their docs), except the ones in `carry`."""
    lines = body.split("\n")
    starts = [i for i, l in enumerate(lines)
              if l[:1] not in (" ", "\t", "") and (l.startswith(TOP_KW) or l.startswith(DECL_KW))]
    starts = sorted(set([0] + starts)) + [len(lines)]
    raw = list(zip(starts, starts[1:]))
    # a comment block (doc comment, `/-! ## section -/` header) belongs to the
    # declaration that follows it, so dropping a declaration drops its docs and
    # never leaves a dangling `/-- … -/` behind (that is a syntax error: the
    # lexer then reads the next `/-!` as part of the open doc comment).
    blocks, i = [], 0
    while i < len(raw):
        a, b = raw[i]
        if not any(DECL.match(l) for l in lines[a:b]) and i + 1 < len(raw):
            b = raw[i + 1][1]
            i += 1
        blocks.append((a, b))
        i += 1
    keep = [True] * len(lines)
    dropped = []
    for idx, (a, _) in enumerate(blocks):
        end = blocks[idx + 1][0] if idx + 1 < len(blocks) else len(lines)
        chunk = lines[a:end]
        # the declaration line itself, not the first line of its doc comment: a
        # multi-line `/-- … -/` has continuation lines that are neither blank nor
        # `-`/`/`-prefixed, so the old test picked one of those and the block's
        # theorem was kept by mistake (Def_ChapterTwoParticleSectorEsaPromoted
        # kept 10 node theorems that way, `--defs-only` notwithstanding).
        head = next((l for l in chunk if DECL.match(l)), "")
        m = DECL.match(head)
        if not m:
            continue
        name = m.group(1).split(".")[-1]
        is_thm = re.match(r"(?:noncomputable\s+)?(?:private\s+)?(?:protected\s+)?"
                          r"(?:theorem|lemma)\b", head) is not None
        if name in carry:
            continue
        if (defs_only and is_thm) or (not defs_only and name in nodes):
            dropped.append(name)
            for j in range(a, end):
                keep[j] = False
    return "\n".join(l for l, k in zip(lines, keep) if k), dropped


def _drop_decl_docs(body):
    """Remove every `/-- … -/` declaration doc comment.

    Only used in `--defs-only` mode, where whole declarations disappear: a doc
    comment whose declaration is gone is not merely dead text, it is a lexer
    error (`unexpected token '/-!'`), because the next `/-!` header is read
    inside the still-open doc comment.
    """
    out, i, lines = [], 0, body.split("\n")
    while i < len(lines):
        if lines[i].lstrip().startswith("/--"):
            while i < len(lines) and "-/" not in lines[i]:
                i += 1
            i += 1
            continue
        out.append(lines[i])
        i += 1
    return "\n".join(out)


def build(chap, deps=(), drops=(), defs_only=True, carry=(), chapter_thm_imports_only=True):
    src = os.path.join(WS, "Definitions", f"Def_{chap}.lean")
    dst = os.path.join(WS, "Definitions", f"Def_{chap}Promoted.lean")
    out = []
    for line in open(src, encoding="utf-8").read().split("\n"):
        s = line.strip()
        if s.startswith("import Theorems.") and chapter_thm_imports_only and _thm_is_local(
                s, set(deps) | {chap}):
            # a node of a chapter we are re-carrying drags that chapter's
            # `Definitions.Def_<chap>` import back in (locally: `has already been
            # declared`), and its Lean name now lives in the Promoted bundle, so
            # on the platform the node could never be published either way
            continue
        m = re.match(r"import Definitions\.Def_(\S+)$", s)
        if m:
            if m.group(1) in drops:
                continue
            if m.group(1) in deps:
                out.append(f"import Definitions.Def_{m.group(1)}Promoted")
                continue
        out.append(line)
    text = "\n".join(out)
    if defs_only:
        text = _drop_decl_docs(text)
    body, dropped = strip(text, node_names(chap), defs_only, set(carry))

    ns = next((m.group(1) for m in (re.match(r"namespace\s+(\S+)", l.strip())
                                    for l in body.split("\n")) if m), None)
    if not ns:
        raise SystemExit(f"Def_{chap}.lean declares no namespace -- nothing to re-carry")
    head = HEADER.format(chap=chap, ns=ns,
                         nsnote=" at all" if "Chapter" not in ns else " under this namespace")
    if dropped:
        head += ("-- Left to the problem nodes on purpose (theorem facts):\n"
                 + "".join(f"--   {d}\n" for d in dropped))
    open(dst, "w", encoding="utf-8").write(head + body)
    print(f"wrote {os.path.relpath(dst, WS)} ({os.path.getsize(dst)} B, {ns}, "
          f"dropped {len(dropped)}, carried {len(carry)})")
    return dropped


def _thm_is_local(import_line, chapters):
    """Is this `Theorems.Thm_…` module a node of one of `chapters`?

    The slug drops the `Chapter` prefix (`Thm_BookProof_CarlemanTwoStep_…`), so a
    plain `_{chap}_` test never matches.
    """
    mod = import_line.split("import Theorems.", 1)[1].strip()
    return any(f"_{c.removeprefix('Chapter')}_" in mod for c in chapters)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapter", nargs="+")
    ap.add_argument("--dep", action="append", default=[],
                    help="stub dependency: its import becomes ...Promoted")
    ap.add_argument("--drop", action="append", default=[],
                    help="bundle the platform does not have at all: import removed")
    ap.add_argument("--defs-only", action="store_true",
                    help="keep definitions only: drop EVERY theorem/lemma, "
                         "including the ones that are not problem nodes (default "
                         "off).  Use it when the chapter's proofs do not compile "
                         "in the gate's environment but its definitions are all "
                         "the consumers need.")
    ap.add_argument("--carry", action="append", default=[],
                    help="node lemma whose body is cited by a definition: keep it here")
    ap.add_argument("--whole", action="store_true",
                    help="re-carry every declaration, nodes included (they get parked)")
    a = ap.parse_args()
    for c in a.chapter:
        carry = node_names(c) if a.whole else set(a.carry)
        build(c, set(a.dep), set(a.drop), a.defs_only, carry)


if __name__ == "__main__":
    main()
