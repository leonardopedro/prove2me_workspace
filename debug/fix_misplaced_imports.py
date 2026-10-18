#!/usr/bin/env python3
"""Hoist `import` lines that sit AFTER the first command up into the import block.

Lean rejects any `import` that is not at the beginning of the file:

    error: invalid 'import' command, it must be used in the beginning of the file

Ten platform failures carry that text.  The generator emits a correct header and
then appends a second, late block of `Definitions.Def_*` imports after `open` /
`variable` / `section` lines — so the file is unfixable as written and the fix is
purely positional: move those imports into the header, preserving their order and
dropping duplicates.

Only touches `Solutions/Sol_*.lean`.  Default is a dry run; `--apply` writes.
"""
import argparse
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
IMPORT_RE = re.compile(r"^import\s+\S")


def hoist(text):
    """Return (new_text, moved_imports)."""
    lines = text.splitlines(keepends=True)
    head, body, seen = [], [], set()
    in_head = True
    for l in lines:
        s = l.strip()
        if in_head and (not s or s.startswith("--") or s.startswith("/-")
                        or s.startswith("-/") or IMPORT_RE.match(l)):
            head.append(l)
            if IMPORT_RE.match(l):
                seen.add(s)
            continue
        in_head = False
        body.append(l)
    moved = []
    kept = []
    for l in body:
        if IMPORT_RE.match(l):
            if l.strip() in seen:
                moved.append(l.strip())          # duplicate: drop
            else:
                seen.add(l.strip())
                head.append(l if l.endswith("\n") else l + "\n")
                moved.append(l.strip())
            continue
        kept.append(l)
    if not moved:
        return text, []
    return "".join(head + kept), moved


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--only", action="append", default=None)
    args = ap.parse_args()

    sols = sorted(os.listdir(os.path.join(WS, "Solutions")))
    changed = 0
    for fn in sols:
        if not fn.startswith("Sol_") or not fn.endswith(".lean"):
            continue
        if args.only and not any(o in fn for o in args.only):
            continue
        p = os.path.join(WS, "Solutions", fn)
        try:
            txt = open(p, encoding="utf-8").read()
        except OSError:
            continue
        new, moved = hoist(txt)
        if not moved:
            continue
        changed += 1
        print(f"{fn}: hoisted {len(moved)} late import(s)")
        for m in moved:
            print(f"    {m}")
        if args.apply:
            with open(p + ".bak_misplimp", "w", encoding="utf-8") as fh:
                fh.write(txt)
            with open(p, "w", encoding="utf-8") as fh:
                fh.write(new)
    print(f"{'rewrote' if args.apply else 'would rewrite'} {changed} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
