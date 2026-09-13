#!/usr/bin/env python3
"""Repair `open` lines left corrupt by an earlier run of debug/fix_gen_imports.py.

Before the namespace stack was hardened, the enclosing namespace was joined in
unconditionally, which produced two corrupt forms:

  `open None.BookProof.X`                                  (parent was a section)
  `open BookProof.A.BookProof.A.Y`                         (parent repeated)

In both cases the module and the intended namespace are still recoverable — only
the rendered name is wrong — so this rewrites the name back and drops the line
when that namespace is already opened in the same file (the doubled form was
usually a redundant duplicate of a correct line that was already there).

Usage: python3 debug/strip_bogus_opens.py [--dry-run]
"""
import glob
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BAD = re.compile(r"^open None\.(\S+)\s*$")


def collapse_doubled(ns):
    """`A.B.A.B.C` -> `A.B.C`, else None."""
    for k in range(2, len(ns)):
        if ns[k - 1] == "." and ns.startswith(ns[:k] * 2):
            return ns[:k] + ns[2 * k:]
    return None


def clean_bogus(ns):
    """Rewrite a corrupt namespace to its intended one, else None.

    The two corruptions compose (`A.None.B.A.C`), so this runs to a fixpoint.
    """
    orig, prev = ns, None
    while ns != prev:
        prev = ns
        ns = ns.replace(".None.", ".")
        if ns.startswith("None."):
            ns = ns[len("None."):]
        d = collapse_doubled(ns)
        if d:
            ns = d
    return ns if ns != orig else None


def main():
    dry = "--dry-run" in sys.argv
    files = sorted(glob.glob(os.path.join(WS, "Theorems", "*.lean")) +
                   glob.glob(os.path.join(WS, "Solutions", "*.lean")) +
                   glob.glob(os.path.join(WS, "Definitions", "*.lean")))
    touched = 0
    for path in files:
        lines = open(path, encoding="utf-8").read().split("\n")
        fixed, out, changed = set(), [], False
        opened = {ln[len("open "):].strip() for ln in lines if ln.startswith("open ")}
        for ln in lines:
            ns = None
            m = BAD.match(ln)
            if m:
                ns = m.group(1)
            elif ln.startswith("open "):
                ns = clean_bogus(ln[len("open "):].strip())
            if ns is None:
                out.append(ln)
                continue
            changed = True
            if ns in opened or ns in fixed:
                continue
            fixed.add(ns)
            out.append(f"open {ns}")
        if changed:
            touched += 1
            print(f"{os.path.relpath(path, WS)}")
            for ns in sorted(fixed):
                print(f"    -> open {ns}")
            if not dry:
                open(path, "w", encoding="utf-8").write("\n".join(out))
    print(f"\n{touched} file(s)" + (" [dry run]" if dry else " repaired"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
