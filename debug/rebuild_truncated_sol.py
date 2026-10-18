#!/usr/bin/env python3
"""Rebuild a truncated sol from the source project (statement-anchored).

PIPELINE_PLAN §2.29-2 established this repair: a sol whose proof was cut off
mid-tactic (trailing `in`, dangling `omit … in`, truncated comment) is rebuilt
as <existing header> + `theorem solution` + the SOURCE declaration's args,
statement and proof body.  Safety rules:

* the Thm stub's statement must match the source statement after whitespace
  normalisation -- the platform's statement is the target, so a mismatch means
  this is not the same theorem and the rebuild is refused (report only);
* the header (imports/opens/variables/set_option) is kept verbatim from the
  existing sol -- it was repaired by fix15/fix23/fix24 and is authoritative;
* the source body is taken verbatim from `:= by` to the next top-level command.

Usage: python3 debug/rebuild_truncated_sol.py <slug>... [--apply]
"""
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.abspath(os.path.join(WS, "..", "timepiece331", "BookProof"))
TOPLEVEL = re.compile(
    r"^(theorem|lemma|def|abbrev|instance|structure|class|inductive|opaque|example|"
    r"section|namespace|end|variable|private|protected|local|open|noncomputable|"
    r"attribute|universe|macro|syntax|scoped|include|omit|set_option|@\[|/\-|#|public\b)")


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def find_toplevel_assign(text, start):
    """Index of the first `:=` at paren/bracket depth 0 at or after `start`,
    else -1.  A plain `text.find(":=")` cuts a statement short when the
    argument list carries a binder default -- measured on
    ChapterHermiteRelativeBound.re_inner_oscL_le_quadOp, whose
    `(u : polyGaussCore (d := d))` made the source statement look 94 chars
    long against the stub's 192 and tripped the mismatch refusal."""
    i, depth = start, 0
    while i < len(text) - 1:
        c = text[i]
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth = max(0, depth - 1)
        elif c == ":" and text[i + 1] == "=" and depth == 0:
            return i
        i += 1
    return -1


def stmt_of(text, name):
    """The declaration's argument+statement text, from the name to `:=`."""
    m = re.search(rf"(?:theorem|lemma)\s+{re.escape(name)}\b", text)
    if not m:
        return None
    i = text.find(":=", m.end())
    if i < 0:
        return None
    return text[m.end():i]


def decl_of(src, name):
    """(statement, full-declaration-text) of `name` in the source chapter,
    renamed to `solution` and with an explicit `:= by` restored."""
    m = re.search(rf"^(\s*(?:private\s+|protected\s+|@\[[^\]]*\]\s*)*)(?:theorem|lemma)\s+{re.escape(name)}\b",
                  src, re.M)
    if not m:
        return None, None
    j = find_toplevel_assign(src, m.end())
    if j < 0:
        return None, None           # match-form theorem: no `:= by` body
    # same-line body (`:= rfl`, `:= by simp ...`) must be kept verbatim
    nl = src.find("\n", j)
    same = src[j + 2:nl].strip()
    lines = src[nl + 1:].splitlines(keepends=True)
    body = []
    for l in lines:
        if l.strip() and TOPLEVEL.match(l):
            break
        body.append(l)
    head = src[m.start():j].rstrip()          # attrs + `theorem <name>` + args + stmt
    head = re.sub(rf"((?:theorem|lemma)\s+){re.escape(name)}",
                  "theorem solution", head, count=1)   # rule 1: top-level `theorem solution`
    if same:
        tail = same if same.startswith("by") else "by " + same
        decl = head + " := " + tail + "\n"
        if not same.startswith("by"):
            pass                               # one-line tactic proof, complete
        else:
            decl += "".join(body)              # `by` may continue on later lines
    else:
        decl = head + " := by\n" + "".join(body)
    stmt = src[m.end():j]
    return stmt, decl


def chapter_of(slug):
    head = open(f"{WS}/Solutions/Sol_{slug}.lean", encoding="utf-8").readline()
    m = re.search(r"Generated from (\S+)\.lean", head)
    return m.group(1) if m else None


def main():
    apply = "--apply" in sys.argv
    slugs = [a for a in sys.argv[1:] if not a.startswith("--")]
    for slug in slugs:
        sol_path = f"{WS}/Solutions/Sol_{slug}.lean"
        thm_path = f"{WS}/Theorems/Thm_{slug}.lean"
        sol = open(sol_path, encoding="utf-8").read()
        thm = open(thm_path, encoding="utf-8").read() if os.path.exists(thm_path) else ""
        chap = chapter_of(slug)
        src_path = f"{SRC}/{chap}.lean" if chap else None
        if not src_path or not os.path.exists(src_path):
            print(f"{slug}: SKIP no source chapter ({chap})")
            continue
        src = open(src_path, encoding="utf-8").read()
        # the declared name: prefer the Thm stub's, fall back to the sol's own
        m = re.search(r"^theorem\s+(\S+)", thm, re.M)
        name = m.group(1).rsplit(".", 1)[-1] if m else None
        if not name:
            m = re.search(r"^theorem\s+(\S+)", sol, re.M)
            name = m.group(1).rsplit(".", 1)[-1] if m else None
        if not name:
            print(f"{slug}: SKIP no `theorem` declaration found in stub or sol")
            continue
        s_stmt, decl = decl_of(src, name)
        if decl is None:
            print(f"{slug}: SKIP source decl `{name}` not found in {chap}")
            continue
        t_stmt = stmt_of(thm, None) if False else None
        tm = re.search(r"^theorem\s+\S+(.*?)\s*:=\s*by sorry", thm, re.S | re.M)
        if not tm:
            print(f"{slug}: SKIP thm stub has no `:= by sorry` statement")
            continue
        if norm(tm.group(1)) != norm(s_stmt):
            print(f"{slug}: SKIP statement mismatch (stub != source)")
            continue
        # header = everything before `theorem solution`
        hm = re.search(r"^theorem solution\b", sol, re.M)
        if not hm:
            print(f"{slug}: SKIP no `theorem solution` line in sol")
            continue
        header = sol[:hm.start()]
        new = header + decl.rstrip() + "\n"
        # A no-op rewrite is NOT harmless: the guard's offline verdict is keyed on
        # mtime (upload_pipeline.offline_fail drops it as stale once the file is
        # newer), so touching the file re-arms an item whose recorded rejection is
        # still true and spends an attempt to be told the same thing.  Measured
        # 2026-10-12 on ChapterAbelianDiagonalCountable_commutes_diagOp_iff and
        # ChapterEulerCountableChain_partial_sum: both rebuilds were byte-identical
        # or a trailing newline, both were re-submitted, both returned the same CE.
        if not apply and new == sol:
            print(f"{slug}: already rebuilt (identical)")
            continue
        if apply and new == sol:
            print(f"{slug}: already rebuilt (identical) [NOT WRITTEN]")
            continue
        if apply:
            bak = sol_path + ".bak_rebuild"
            if not os.path.exists(bak):
                open(bak, "w", encoding="utf-8").write(sol)
            open(sol_path, "w", encoding="utf-8").write(new)
        print(f"{slug}: rebuilt ({len(sol.splitlines())} -> {len(new.splitlines())} lines)"
              f"{' [APPLIED]' if apply else ''}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
