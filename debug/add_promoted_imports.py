#!/usr/bin/env python3
"""Give every consumer of a skeleton def bundle its Promoted replacement.

A chapter whose published `Def_ChapterX` is an empty skeleton cannot supply the
vocabulary its statements use (`open BookProof.X` fails with `unknown namespace`).
After the §2.13 new-name bundle `Def_ChapterXPromoted` exists, the only change a
consumer needs is one import line, exactly as the existing Promoted bundles do
(`Def_ChapterG3Promoted`, `Def_ChapterFriedrichsCanonicalPromoted`, …).

This edits `Theorems/Thm_*.lean` and `Solutions/Sol_*.lean` in place, and only
those that already import `Definitions.Def_<X>` (a consumer of the chapter's
namespace comes through that import).  The line is inserted directly after it, so
the import order stays readable and `import Definitions.Def_<X>` keeps its place
(the platform's skeleton declares nothing, so keeping it is harmless).

Usage:
  python3 debug/add_promoted_imports.py ChapterCarlemanTwoStep [--apply]
  # without --apply it only reports what it would touch
"""
import argparse
import os
import re

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIRS = ("Theorems", "Solutions")


def consumers(chap):
    pat = re.compile(rf"^import Definitions\.Def_{re.escape(chap)}\s*$", re.M)
    for d in DIRS:
        root = os.path.join(WS, d)
        if not os.path.isdir(root):
            continue
        for name in sorted(os.listdir(root)):
            if not name.endswith(".lean"):
                continue
            path = os.path.join(root, name)
            txt = open(path, encoding="utf-8", errors="ignore").read()
            if pat.search(txt):
                yield path, txt


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapter", nargs="+")
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()
    total = 0
    for chap in a.chapter:
        promo = f"Definitions.Def_{chap}Promoted"
        n = 0
        for path, txt in consumers(chap):
            if re.search(rf"^import {re.escape(promo)}\s*$", txt, re.M):
                continue
            new = re.sub(rf"^(import Definitions\.Def_{re.escape(chap)}\s*)$",
                         rf"\1\nimport {promo}", txt, count=1, flags=re.M)
            if new == txt:
                continue
            n += 1
            if a.apply:
                open(path, "w", encoding="utf-8").write(new)
        total += n
        print(f"{chap}: {n} consumer file(s) {'updated' if a.apply else 'would be updated'}")
    print(f"total {total}")


if __name__ == "__main__":
    main()
