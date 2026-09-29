#!/usr/bin/env python3
"""Repair solution files whose `open BookProof.X` is not declared by their imports.

Same generator gap as the theorem stubs (`debug/fix_bare_opens.py`), on the solution
side: the file opens namespaces that no module in its import closure declares, and
Lean rejects the file up-front — the server reports
`verdict CE: ... unknown namespace BookProof.X`.

For each unresolved namespace this finds a `Definitions.Def_*` bundle that declares
it and adds that import.  Namespaces declared by **no** bundle exist only in the
source chapter; with `--drop` their `open` line is removed instead (an unresolvable
`open` is a guaranteed hard error, so removing it can only help).

Namespace scanning uses `debug/restore_opens.py:scan`, which tracks `section`/`end`
in the same stack as `namespace` — an earlier revision popped on every `end`, so a
section's end closed the enclosing namespace and valid opens were misjudged.

Usage:
  python3 debug/fix_sol_ns_imports.py --dry-run [--drop] [--only SUBSTR]
  python3 debug/fix_sol_ns_imports.py [--drop]
"""
import argparse
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from restore_opens import OPEN_RE, scan  # noqa: E402

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
SOLS = os.path.join(WS, "Solutions")
IMPORT_RE = re.compile(r'^import\s+Definitions\.(?P<mod>\S+)\s*$', re.M)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    ap.add_argument("--drop", action="store_true",
                    help="remove opens no def bundle can declare (they are hard errors)")
    a = ap.parse_args()

    ns_owner, direct = {}, {}
    for fn in sorted(os.listdir(DEFS)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        mod = fn[4:-5]
        ns, _ = scan(open(os.path.join(DEFS, fn)).read().split("\n"))
        direct[mod] = ns
        for n in ns:
            ns_owner.setdefault(n, set()).add(mod)

    def closure(mods):
        # Only the file's **direct** imports count.  The platform's published module
        # graph is not guaranteed to match the local transitive one (`Def_ChapterBandEnclosure`
        # imports HermiteGalerkinFriedrichs locally, but a solution that relies on that
        # transitivity still got `unknown namespace BookProof.HermiteGalerkin` from the
        # server), so every namespace a file opens must be declared by a module the file
        # imports itself.
        return set().union(*(direct.get(m, set()) for m in mods)) if mods else set()

    patched = blocked = 0
    for fn in sorted(f for f in os.listdir(SOLS) if f.endswith(".lean")):
        if a.only and not any(s in fn for s in a.only):
            continue
        path = os.path.join(SOLS, fn)
        txt = open(path).read()
        want = {n for grp in OPEN_RE.findall(txt) for n in grp.split()
                if n.startswith("BookProof.")}
        if not want:
            continue
        have_mods = {(m[4:] if m.startswith("Def_") else m) for m in IMPORT_RE.findall(txt)}
        missing = want - closure(have_mods)
        if not missing:
            continue
        add, unres = set(), set()
        for n in sorted(missing):
            owners = ns_owner.get(n)
            if not owners:
                unres.add(n)
                continue
            for mod in sorted(owners):
                if mod not in have_mods:
                    add.add(mod)
                    break
        if unres and not a.drop:
            print(f"{fn}: BLOCKED {sorted(unres)} (no def bundle declares them)")
            blocked += 1
        if not add and not (unres and a.drop):
            continue
        print(f"{fn}: +import {sorted(add)}"
              + (f" -open {sorted(unres)}" if unres and a.drop else ""))
        patched += 1
        if a.dry_run:
            continue
        lines = txt.split("\n")
        if unres and a.drop:
            keep = []
            for l in lines:
                m = OPEN_RE.match(l)
                if m:
                    names = [n for n in m.group(1).split() if n not in unres]
                    if not names:
                        continue
                    l = ("open scoped " if l.startswith("open scoped") else "open ") + " ".join(names)
                keep.append(l)
            lines = keep
        last = max(i for i, l in enumerate(lines) if l.startswith("import "))
        for mod in sorted(add):
            lines.insert(last + 1, f"import Definitions.Def_{mod}")
        open(path, "w").write("\n".join(lines))

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s), {blocked} blocked")
    return 0


if __name__ == "__main__":
    sys.exit(main())
