#!/usr/bin/env python3
"""Which duplicated `variable` binders actually break a stub's target?

`dedup_variable_binders.py` flags every re-declaration of a name, but most are
harmless: a name the statement never uses can be declared twice without any
effect (442 of the 583 corpus-wide hits are `done/done` -- statement published
and sol Proved, so their targets were fine).

The harmful shape is narrower: a hypothesis the stub `include`s mentions `N`,
and `N` is declared AGAIN after that hypothesis.  The hypothesis then binds the
EARLIER `N` while the statement binds the later one, so the target constrains a
different object than it concludes about (PIPELINE_PLAN §8.1).

Usage:
  python3 debug/find_dupvar_conflicts.py Theorems/Thm_*.lean
  python3 debug/find_dupvar_conflicts.py --from-file state/scratch/dupvar_all.txt
  python3 debug/find_dupvar_conflicts.py --slugs ... # print slug, one per line
"""
import argparse
import glob
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import dedup_variable_binders as dd  # noqa: E402

STOP = ("theorem", "lemma", "def", "abbrev", "instance", "structure", "end",
        "namespace", "open", "import", "noncomputable", "set_option", "omit",
        "include", "attribute", "section", "variable", "universe", "example",
        "--", "/-")


def analyse(text):
    """[(name, first_index, later_index, hypothesis)] for real conflicts."""
    lines = text.split("\n")
    cmds = []
    i = 0
    while i < len(lines):
        if not re.match(r"^variable(\s|$)", lines[i]):
            i += 1
            continue
        block, j = [lines[i]], i + 1
        while (j < len(lines) and lines[j][:1].isspace() and lines[j].strip()
               and not lines[j].strip().startswith(STOP)):
            block.append(lines[j])
            j += 1
        cmds.append((i, j, dd.split_groups(block)))
        i = j
    # name -> [(cmd index, group text)]
    where = {}
    for ci, (_s, _e, groups) in enumerate(cmds):
        for g in groups:
            for nm in dd.group_names(g):
                where.setdefault(nm, []).append((ci, g))
    # which hypotheses does the file include?  `include a b c in`
    included = []
    for m in re.finditer(r"(?m)^\s*include\s+(.+?)\s+in\s*$", text):
        included.extend(m.group(1).split())
    out = []
    for h in included:
        decl = where.get(h)
        if not decl:
            continue
        ci, g = decl[0]
        body = g[1:-1] if g[:1] in "({[" else g
        body = body.split(":", 1)[1] if ":" in body else body
        for nm in where:
            if nm == h or nm not in body:
                continue
            later = [c for c, _ in where[nm] if c > ci]
            if later:
                out.append((nm, ci, later[0], h))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("paths", nargs="*")
    ap.add_argument("--from-file", default=None,
                    help="slug per line (bare, BookProof_… or file path)")
    ap.add_argument("--slugs", action="store_true")
    a = ap.parse_args()
    paths = list(a.paths)
    if a.from_file:
        for l in open(a.from_file):
            s = l.strip()
            if not s:
                continue
            if os.path.exists(s):
                paths.append(s)
            else:
                paths.append(os.path.join(WS, "Theorems",
                                          "Thm_%s.lean" % s.lstrip("/")))
    if not paths:
        paths = glob.glob(os.path.join(WS, "Theorems", "Thm_*.lean"))
    hits = 0
    for p in paths:
        base = os.path.basename(p)
        if not base.startswith("Thm_"):
            continue
        try:
            text = open(p, encoding="utf-8").read()
        except OSError:
            continue
        conf = analyse(text)
        if not conf:
            continue
        hits += 1
        slug = base[4:-5]
        if a.slugs:
            print(slug)
            continue
        names = sorted({c[0] for c in conf})
        print("%-70s %s" % (slug, ",".join(names)))
    print("# %d of %d stub(s) carry a conflicting re-declaration" % (hits, len(paths)),
          file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
