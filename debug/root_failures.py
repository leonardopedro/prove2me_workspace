#!/usr/bin/env python3
"""Classify mirror builds with no .olean into ROOT failures vs cascade.

A ROOT failure is a def whose own imports all produced oleans but which
failed itself -- these are the real content errors.  Cascade rows are
downstream noise (they showed up as `object file ... not found` rows,
68/134 in build133).
"""
import os
import re

MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
REPORT = os.environ.get("BUILD_REPORT", "/tmp/build133_report.tsv")
IMP = re.compile(r"^import\s+(Definitions\.\S+|Theorems\.\S+)", re.M)


def main():
    rep = {}
    with open(REPORT, encoding="utf-8") as fh:
        for line in fh:
            st, ch = line.rstrip("\n").split("\t")
            rep[ch] = st
    tset = {"Def_" + c for c in rep}
    mird = sorted(f[:-5] for f in os.listdir(f"{MIRROR}/Definitions")
                  if f.endswith(".lean"))
    nolean = [m for m in mird
               if not os.path.exists(f"{MIRROR}/Definitions/{m}.olean")]
    print("staged defs with no olean:", len(nolean))
    roots, cascade = [], []
    for m in nolean:
        txt = open(f"{MIRROR}/Definitions/{m}.lean",
                   encoding="utf-8", errors="ignore").read()
        bad = []
        for mod in IMP.findall(txt):
            src, name = mod.split(".")
            if not os.path.exists(f"{MIRROR}/{src}/{name}.olean"):
                bad.append(mod)
        (cascade if bad else roots).append((m, bad))
    print("ROOT failures (deps all built):", len(roots))
    for m, _ in roots:
        tgt = "TARGET" if m in tset else "dep   "
        print("  ", tgt, m, "| report:", rep.get(m[4:], "-")[:70])
    print("cascade-only:", len(cascade))
    for m, bad in cascade[:10]:
        print("   cascade:", m, "blocked by", bad[0])


if __name__ == "__main__":
    main()
