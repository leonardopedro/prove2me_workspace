#!/usr/bin/env python3
"""Drop wave-spec thm slugs that are duplicates by construction.

The §5a repairs *embedded* some declarations into their def bundle
(`Def_ChapterStoneResolvent` declares
`BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.{resCLM_mem,res_shift,...}`),
so a separate node for the same declaration can never publish — the server answers
`... has already been declared` and the item burns all 5 attempts.

Detection is exact: read the stub's own `theorem` name, split it into declaring
namespace + base, and check whether a `Definitions.Def_*` bundle declares that base
inside that same namespace.  Namespace scanning uses the corrected
`debug/restore_opens.py:scan` (an earlier inline scanner popped the namespace stack
on a section's `end` and found nothing).

Usage:
  python3 debug/drop_embedded_dups.py --dry-run
  python3 debug/drop_embedded_dups.py
"""
import argparse
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from restore_opens import scan  # noqa: E402

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")
SPEC = os.path.join(WS, "pipeline", "wave_upload.json")
THM_RE = re.compile(r'^theorem\s+([A-Za-z_][\w.\'!?]*)', re.M)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()

    decls = {}
    for fn in sorted(os.listdir(DEFS)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        _, d = scan(open(os.path.join(DEFS, fn)).read().split("\n"))
        for key in d:
            decls.setdefault(key, fn[4:-5])

    spec = json.load(open(SPEC))
    drop = []
    for slug in list(spec["thms"]):
        path = os.path.join(THMS, f"Thm_{slug}.lean")
        if not os.path.exists(path):
            continue
        m = THM_RE.search(open(path).read())
        if not m:
            continue
        ns, _, base = m.group(1).rpartition(".")
        if (ns, base) in decls:
            drop.append(slug)
            print(f"DROP {slug}  (declared by Def_{decls[(ns, base)]})")

    if not drop:
        print("no embedded duplicates found")
        return 0
    print(f"\n{'would drop' if a.dry_run else 'dropping'} {len(drop)} slug(s); "
          f"spec {len(spec['thms'])} thms -> {len(spec['thms']) - len(drop)}")
    if a.dry_run:
        return 0
    victims = set(drop)
    spec["thms"] = [s for s in spec["thms"] if s not in victims]
    spec["sol_order"] = [s for s in spec["sol_order"] if s not in victims]
    with open(SPEC, "w") as f:
        json.dump(spec, f, indent=1)
    return 0


if __name__ == "__main__":
    sys.exit(main())
