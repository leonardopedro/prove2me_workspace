#!/usr/bin/env python3
"""Regenerate the header of a stub that was written with no preamble at all.

Measured 2026-11-05: 79 `Theorems/Thm_*.lean` files begin directly with
`theorem ...` — no `import`, no `open`, no `variable`.  The comment header even
ends with `-- Generated from X.lean — ` and then nothing, so the generator built
the file but produced an EMPTY preamble.  Every one of them fails the offline
gate with errors that look like statement defects but are not:

  ChapterG_haarAverage_one   L:3:51  Unknown identifier `X`
  ChapterF3_projOnto_isSymmetric L:3:54 Unknown identifier `E`
  QgOuterFockOneParticle_single_mem_secCore  ... `secCore`

24 of them are still pending (23 pairs + 1 sol-only), which is why the
"unresolved stub provider" class kept reappearing: the missing provider was the
chapter's own `variable` line, not a name in a published bundle.

The fix is to re-run the generator's own `build_thm`/`build_sol` for exactly
those nodes and keep the result ONLY if it now has an `import` line.  Nothing is
regenerated that already has a header, so hand-repaired stubs in the same
chapter are untouched, and every written file keeps a `.bak_hdr` copy.

Only the HEADER is taken from the regeneration: the declaration text stays the
one already in the file.  The sketch spans of several of these chapters are
stale (`look misaligned`, e.g. ChapterG 4/43), and `the_statement` on a
misaligned span returns a fragment -- regenerating the whole file produced
`theorem ... : haarAverage (μG := by sorry` for `ChapterG_haarAverage_one`,
whose statement in the existing file is complete and correct.

Usage:
    python3 debug/regen_headerless_stubs.py                 # report only
    python3 debug/regen_headerless_stubs.py --apply
    python3 debug/regen_headerless_stubs.py --apply --only Qg   # substring filter
"""
import argparse
import json
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "scripts"))

import wave_generate as wg  # noqa: E402


def headerless(slugs=None):
    out = []
    d = os.path.join(WS, "Theorems")
    for fn in sorted(os.listdir(d)):
        if not (fn.startswith("Thm_") and fn.endswith(".lean")):
            continue
        slug = fn[len("Thm_"):-len(".lean")]
        if slugs is not None and slug not in slugs:
            continue
        txt = open(os.path.join(d, fn), encoding="utf-8").read()
        if not re.search(r"(?m)^import ", txt):
            out.append(slug)
    return out


def sol_headerless(slug):
    p = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
    if not os.path.exists(p):
        return False
    txt = open(p, encoding="utf-8").read()
    return not re.search(r"(?m)^(import|theorem|lemma) ", txt)


def leaf_of(slug):
    """`BookProof_ChapterG_haarAverage_one` -> `ChapterG`.

    The slug is `uname.replace(".", "_")`, so the leaf is the second
    dot-separated segment of the recorded name.  Reading it from the stub's own
    `-- Generated from X.lean` comment is exact and needs no guessing.
    """
    fn = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
    m = re.search(r"Generated from (\S+)\.lean", open(fn, encoding="utf-8").read())
    return m.group(1) if m else None


def has_import(text):
    return bool(re.search(r"(?m)^import ", text))


def split_decl(text):
    """(preamble, declaration) at the first `theorem`/`lemma` line."""
    m = re.search(r"(?m)^(?:theorem|lemma)\s", text)
    if not m:
        return text, ""
    return text[:m.start()], text[m.start():]


def splice_header(new_text, old_text, sub):
    """Keep the OLD declaration, take the NEW preamble, and drop the old
    `-- Generated from ...` comment so the regenerated one is not duplicated."""
    new_pre, _ = split_decl(new_text)
    _, old_decl = split_decl(old_text)
    if not old_decl.strip() or ":=" not in old_decl:
        return None
    return new_pre + old_decl.rstrip() + "\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--only", default=None, help="substring filter on the slug")
    ap.add_argument("--force", action="store_true",
                    help="regenerate the header even if the stub already has one "
                         "(the declaration text is still preserved), e.g. after a "
                         "fix to structural_preamble rather than to the stub")
    ap.add_argument("--from-file", dest="from_file", default=None,
                    help="slugs to consider, one per line")
    a = ap.parse_args()

    pending = set()
    try:
        items = json.load(open(os.path.join(WS, "state/pipeline.json"))).get("items") or {}
        for k, rec in items.items():
            if (rec or {}).get("status") in ("pending", "failed"):
                pending.add(k.split(":", 1)[1])
    except OSError:
        pass

    if a.from_file:
        slabs = [(l.strip()) for l in open(a.from_file) if l.strip()]
        if a.force:
            have = set(headerless())
            slugs = [s for s in slabs if a.force or s in have]
        else:
            have = set(headerless())
            slugs = [s for s in slabs if s in have]
    else:
        slugs = headerless()
    if a.only:
        slugs = [s for s in slugs if a.only in s]
    todo, skipped = [], []
    for s in slugs:
        if pending and s not in pending:
            skipped.append(s)
        else:
            todo.append(s)
    print(f"candidates: {len(slugs)} total, {len(todo)} actionable, "
          f"{len(skipped)} not pending")

    graph = wg.load_graph()
    by_leaf = {}
    for s in todo:
        leaf = leaf_of(s)
        if leaf:
            by_leaf.setdefault(leaf, []).append(s)
        else:
            print(f"  NOLEAF {s}")

    written, still = [], []
    for leaf, want in sorted(by_leaf.items()):
        try:
            decls = wg.load_decls(leaf, graph)
            bt = wg.src_byte_text(leaf)
            modns = wg.module_namespace(leaf)
        except Exception as e:                                  # noqa: BLE001
            print(f"  {leaf}: cannot load source ({str(e)[:160]})")
            still.extend(want)
            continue
        doc = wg.module_doc(bt)
        defmat, embedded, nodes, inline = wg.classify(decls, doc, bt)
        for nd in nodes:
            if not wg.node_span_is_sane(bt, nd):
                wg.realign_node(bt, nd)
        by_name = {}
        for nd in nodes:
            by_name[nd.uname.replace(".", "_")] = nd
        for s in want:
            nd = by_name.get(s)
            if nd is None:
                print(f"  NODE {s} not found in {leaf}")
                still.append(s)
                continue
            thm_txt = wg.build_thm(bt, leaf, decls, nd, modns)
            sol_txt = wg.build_sol(bt, leaf, decls, nodes, inline, nd, modns)
            got = []
            thm_path = os.path.join(WS, "Theorems", f"Thm_{s}.lean")
            if has_import(thm_txt):
                spliced = splice_header(thm_txt, open(thm_path, encoding="utf-8").read(),
                                        "Theorems")
                if spliced:
                    got.append(("Theorems", f"Thm_{s}.lean", spliced))
                else:
                    print(f"  SKIP {s}: no usable declaration in the old file")
            else:
                print(f"  STILL {s}: build_thm still has no import")
            sol_path = os.path.join(WS, "Solutions", f"Sol_{s}.lean")
            if sol_headerless(s) and re.search(r"(?m)^import ", sol_txt):
                spliced = splice_header(sol_txt, open(sol_path, encoding="utf-8").read(),
                                        "Solutions")
                if spliced:
                    got.append(("Solutions", f"Sol_{s}.lean", spliced))
            for sub, fn, text in got:
                p = os.path.join(WS, sub, fn)
                if a.apply:
                    bak = p + ".bak_hdr"
                    if not os.path.exists(bak):
                        shutil.copy2(p, bak)
                    open(p, "w", encoding="utf-8").write(text)
                written.append(f"{sub}/{fn}")
            if got:
                print(f"  {'wrote' if a.apply else 'would write'} {s}"
                      f" ({len(got[0][2].splitlines())} lines)")
            else:
                still.append(s)
    print(f"\n{'wrote' if a.apply else 'would write'} {len(written)} file(s); "
          f"{len(still)} still headerless")
    return 0 if not still else 1


if __name__ == "__main__":
    sys.exit(main())
