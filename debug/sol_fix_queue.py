#!/usr/bin/env python3
"""Classify every pending sol into a FIX QUEUE, so proof defects can be worked
in priority order instead of by scanning thousands of rows.

Reads the cached offline verdicts (`state/offline_pending_check.json`, written by
`check_pending_offline.py`) plus `state/pipeline.json`, and for each pending sol
records ONE class:

  SUBMIT            the production guard defers nothing -> uploadable now
  pub-def           `unpublished def import X`   -> publication gate, ~700 sols
  pub-sib           `unpublished sibling import` -> publication gate
  pub-thm           `unknown import: Theorems.X No such theorem exists`
  mirror-artifact   `object file ... does not exist` on a module the platform
                    publishes -> the guard ignores it, not a defect (§2.36)
  miss-ident        `Unknown identifier 'X'`      -> real, actionable
  miss-namespace    `unknown namespace 'X'`       -> the §2.32 hollow-`open` class
  miss-const        `Unknown constant 'X'`
  goals             `unsolved goals`              -> real, actionable
  other-defect      anything else that is not a publication gate

Writes /tmp/fixq_<class>.txt (one slug per line) and prints the census with an
example per class.  Also reports how many of each class carry a STALE cached
verdict (the local file was edited after it: it cannot be trusted, §2.37-3).

Usage:
  python3 debug/sol_fix_queue.py                  # census
  python3 debug/sol_fix_queue.py --class miss-ident --show
"""
import argparse
import collections
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))

import upload_pipeline as up  # noqa: E402

CLASSES = ["SUBMIT", "pub-def", "pub-sib", "pub-thm", "mirror-artifact",
           "miss-ident", "miss-namespace", "miss-const", "goals", "other-defect"]

RE_MISS_IDENT = re.compile(r"Unknown identifier [`']([^`']+)")
RE_MISS_CONST = re.compile(r"Unknown constant [`']([^`']+)")
RE_MISS_NS = re.compile(r"unknown namespace [`']([^`']+)")
RE_PUB_DEF = re.compile(r"unpublished def import (\S+)")
RE_PUB_SIB = re.compile(r"unpublished sibling import (\S+)")
RE_PUB_THM = re.compile(r"unknown import: (Theorems\.\S+)")
# Guard phrasing for a sibling THEOREM the platform does not serve.  Measured
# second-largest class (2,069 sols) and, like the def phrase above, it is a
# publication gate rather than a proof defect.
RE_PUB_SIB2 = re.compile(
    r"sibling theorem not published on the platform: (\S+)")
# The submission-guard phrasing for a def bundle the platform does not serve:
# "def bundle not published on the platform: ChapterBddBelowWallEsa".  It is
# the SAME fact as `unpublished def import X` and must not land in other-defect,
# where this census first buried 3,020 of 3,401 sols.
RE_PUB_DEF2 = re.compile(r"def bundle not published on the platform: (\S+)")


def classify(reason):
    if not reason:
        return "SUBMIT", ""
    if RE_PUB_DEF2.search(reason):
        return "pub-def", RE_PUB_DEF2.search(reason).group(1)
    if RE_PUB_DEF.search(reason):
        return "pub-def", RE_PUB_DEF.search(reason).group(1)
    if RE_PUB_SIB2.search(reason):
        return "pub-sib", RE_PUB_SIB2.search(reason).group(1)
    if RE_PUB_SIB.search(reason):
        return "pub-sib", RE_PUB_SIB.search(reason).group(1)
    if RE_PUB_THM.search(reason):
        return "pub-thm", RE_PUB_THM.search(reason).group(1)
    if "object file" in reason:
        return "mirror-artifact", ""
    m = RE_MISS_IDENT.search(reason)
    if m:
        return "miss-ident", m.group(1)
    m = RE_MISS_NS.search(reason)
    if m:
        return "miss-namespace", m.group(1)
    m = RE_MISS_CONST.search(reason)
    if m:
        return "miss-const", m.group(1)
    if "unsolved goal" in reason:
        return "goals", ""
    return "other-defect", reason[:90].replace("\t", " ")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--class", dest="cls", default=None)
    ap.add_argument("--show", action="store_true",
                    help="print the reasons of the selected class")
    args = ap.parse_args()

    st = up.load_state()["items"]
    # Truthiness gate: the guard refuses to answer without the platform
    # catalogue, and a census computed with dependency checking off is a lie.
    up.published_defs()

    rows = []
    for key in sorted(st):
        kind, _, name = key.partition(":")
        if kind != "sol" or st[key].get("status") != "pending":
            continue
        path = up.item_source(key)
        if not os.path.exists(path):
            continue
        verdict, reason = up.submission_guard("sol", name, path)
        cls, detail = ("SUBMIT", "") if not verdict else classify(reason or "")
        stale = False
        try:
            stale = os.path.getmtime(up.OFFLINE_CHECK) < os.path.getmtime(path)
        except OSError:
            pass
        rows.append((cls, name, detail, stale, st[key].get("attempts", 0)))

    census = collections.Counter(r[0] for r in rows)
    open("/tmp/fixq_all.tsv", "w").write(
        "".join(f"{c}\t{n}\t{d}\t{'stale' if s else 'fresh'}\t{a}\n"
                for c, n, d, s, a in rows))
    for cls in CLASSES:
        names = [n for c, n, _, _, _ in rows if c == cls]
        open(f"/tmp/fixq_{cls}.txt", "w").write(
            "".join(f"{n}\n" for n in names))
    print(f"pending sols with a local source: {len(rows)}")
    print(f"{'class':16s} {'n':>5s}  {'stale-verdict':>13s}  example detail")
    for cls in CLASSES:
        sel = [r for r in rows if r[0] == cls]
        if not sel:
            continue
        stale = sum(1 for r in sel if r[3])
        print(f"{cls:16s} {len(sel):5d}  {stale:13d}  {sel[0][2][:70]}")
    print(f"\ncensus written to /tmp/fixq_all.tsv, per-class lists to /tmp/fixq_<class>.txt")

    if args.cls:
        sel = [r for r in rows if r[0] == args.cls]
        if args.show:
            for c, n, d, s, a in sel:
                print(f"  {n}\t{'stale' if s else 'fresh'}\tattempts={a}\t{d}")
        else:
            print(f"\n{args.cls}: {len(sel)} item(s)")
            for c, n, d, s, a in sel[:40]:
                print(f"  {n}\t{d[:80]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
