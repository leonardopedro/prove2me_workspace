#!/usr/bin/env python3
"""Add the `lp` scope to stubs whose statement uses the `ℓ²` notation.

Generator gap: `ℓ²(ℕ, ℂ)` is notation only inside the `lp` scope.  The def bundle
carries `open scoped InnerProductSpace ENNReal lp`; the generated stub copies only
`open scoped InnerProductSpace ENNReal`, so the server rejects the statement with
`unexpected token '²'`.

This adds `lp` (only that) to the stub's top-level `open scoped` line when the file
uses `ℓ²` and the scope is missing.  A wider union of every transitive def-bundle
scope was measured to touch 1312 stubs for no reason, so the rule is deliberately
narrow.

Usage:
  python3 debug/fix_scoped_opens.py --dry-run [--only SUBSTR]
  python3 debug/fix_scoped_opens.py
"""
import argparse
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
THMS = os.path.join(WS, "Theorems")

SCOPED_RE = re.compile(r'^open[ \t]+scoped[ \t]+([A-Za-z_][\w.]*(?:[ \t]+[A-Za-z_][\w.]*)*)[ \t]*$', re.M)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    a = ap.parse_args()

    patched = 0
    for fn in sorted(f for f in os.listdir(THMS) if f.endswith(".lean")):
        if a.only and not any(s in fn for s in a.only):
            continue
        path = os.path.join(THMS, fn)
        txt = open(path).read()
        if "ℓ²" not in txt:
            continue
        lines = txt.split("\n")
        hit = None
        for i, l in enumerate(lines):
            m = SCOPED_RE.match(l)
            if m:
                hit = (i, m.group(1).split())
                break
        if hit and "lp" in hit[1]:
            continue
        print(f"{fn}: +scoped lp")
        patched += 1
        if a.dry_run:
            continue
        if hit:
            i, names = hit
            lines[i] = "open scoped " + " ".join(sorted(set(names) | {"lp"}))
        else:
            last_imp = max(i for i, l in enumerate(lines) if l.startswith("import "))
            lines.insert(last_imp + 1, "open scoped lp")
        open(path, "w").write("\n".join(lines))

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
