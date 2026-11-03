#!/usr/bin/env python3
"""List, per local file, the module pairs that co-provide one fq name.

The counterpart of `audit_dup_providers.py`: that tool answers "which names have
more than one published provider"; this one answers "which of OUR files import
two of them at once", i.e. the files Lean rejects with

    import Definitions.Def_X failed, environment already contains 'N' from ...

Emitting the pair (not just the name) matters because the repair is always
"drop one import", and which import is droppable depends on what else the file
needs from each side.

READ-ONLY.

Usage:
  python3 debug/list_provider_conflicts.py [--tsv state/scratch/provider_conflicts.tsv]
"""
import argparse
import os
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import audit_dup_providers as A  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--tsv", default=None)
    args = ap.parse_args()

    bundles = A.published_bundles()
    by_bundle = defaultdict(set)
    for b, (decls, _p) in bundles.items():
        for fq, _k in decls:
            by_bundle[fq].add(b)

    imp = A.importers()

    def mod(b):
        return f"Definitions.Def_{b}"

    pairs = defaultdict(set)      # (modA, modB) -> {names}
    for fq, bs in by_bundle.items():
        if len(bs) < 2:
            continue
        bs = sorted(bs)
        for i in range(len(bs)):
            for j in range(i + 1, len(bs)):
                ma, mb = mod(bs[i]), mod(bs[j])
                if imp.get(ma, set()) & imp.get(mb, set()):
                    pairs[(ma, mb)].add(fq)

    if not pairs:
        print("no local file imports two providers of the same name")
        return 0

    rows = []
    for (ma, mb), names in sorted(pairs.items()):
        both = sorted(os.path.relpath(f, A.WS) for f in imp[ma] & imp[mb])
        for f in both:
            rows.append((f, ma, mb, len(names), ",".join(sorted(names))))

    print(f"{'file':70s} {'pair':58s} {'#names':>6s}")
    for f, ma, mb, n, _names in rows:
        print(f"{f:70s} {ma.replace('Definitions.Def_', '')} x "
              f"{mb.replace('Definitions.Def_', ''):28s} {n:6d}")

    if args.tsv:
        os.makedirs(os.path.dirname(args.tsv), exist_ok=True)
        with open(args.tsv, "w", encoding="utf-8") as fh:
            fh.write("file\tmodule_a\tmodule_b\tcount\tnames\n")
            for r in rows:
                fh.write("\t".join(str(x) for x in r) + "\n")
        print(f"\nwrote {args.tsv} ({len(rows)} row(s))")
    return 0


if __name__ == "__main__":
    sys.exit(main())
