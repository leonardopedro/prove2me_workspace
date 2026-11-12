#!/usr/bin/env python3
"""Insert a carried lemma into a Promoted def bundle, with its real proof.

WHY: once `debug/fill_promoted_proofs.py` has replaced the `:= by sorry`
placeholders by the timepiece proofs, a repaired proof can cite a chapter lemma
that the generator dropped (it is a problem node).  The bundle then fails with
`Unknown identifier <name>`.  Re-carrying the cited lemma -- verbatim from the
timepiece source, so the bundle stays `sorry`-free -- is the minimal repair.

The block is inserted immediately before the declaration that first cites the
name, which is the earliest point at which it must be in scope.

Usage:
  python3 debug/add_promoted_carry.py ChapterCarlemanSimplex sum_range_of_multiplicity
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fill_promoted_proofs as fp  # noqa: E402


def insert(chap, names):
    dst = os.path.join(fp.WS, "Definitions", f"Def_{chap}Promoted.lean")
    lines = open(dst, encoding="utf-8").read().split("\n")
    proofs = fp.timepiece_proofs(chap)
    rc = 0
    for name in names:
        text = proofs.get(name)
        if not text:
            print(f"{chap}: no timepiece block for {name}")
            rc = 1
            continue
        if "sorry" in text:
            print(f"{chap}: timepiece block for {name} still uses `sorry`")
            rc = 1
            continue
        starts = [i for i, l in enumerate(lines)
                  if l[:1] not in (" ", "\t", "") and fp.DECL.match(l)]
        used_at = next((i for i, l in enumerate(lines)
                        if re.search(rf"(?<![\w.']){re.escape(name)}(?![\w'])", l)
                        and fp.DECL.match(l) is None), None)
        if used_at is None:
            print(f"{chap}: {name} is not cited by the bundle -- not inserting")
            continue
        at = max([a for a in starts if a <= used_at], default=0)
        if fp.DECL.match(lines[at]).group(1).split(".")[-1] == name:
            print(f"{chap}: {name} already declared")
            continue
        lines[at:at] = text.split("\n") + [""]
        print(f"{chap}: carried {name} before line {at + 1}")
    open(dst, "w", encoding="utf-8").write("\n".join(lines))
    return rc


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit(__doc__)
    sys.exit(insert(sys.argv[1], sys.argv[2:]))
