#!/usr/bin/env python3
"""Reopen items the runner has parked at `failed`.

`upload_pipeline.py` stops selecting an item once it reaches MAX_ATTEMPTS and
never revisits it, so a defect at the *submit boundary* (the title byte-cap, the
statement splitter) strands every item it broke.  This tool reopens those items
so a fixed boundary can actually retry them.

Usage:
    python3 debug/reopen_failed.py                # list the failed items
    python3 debug/reopen_failed.py --yes          # reopen all of them
    python3 debug/reopen_failed.py --yes --only SUBSTR
"""
import argparse
import json
import os
import shutil
import sys

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(WS, "state", "pipeline.json")


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--yes", action="store_true", help="actually write (default: dry run)")
    ap.add_argument("--only", action="append", default=[], help="reopen only items containing this substring")
    args = ap.parse_args(argv)

    st = json.load(open(STATE, encoding="utf-8"))
    items = st.setdefault("items", {})
    targets = [
        k for k, rec in items.items()
        if rec.get("status") == "failed" and (not args.only or any(o in k for o in args.only))
    ]

    if not targets:
        print("no failed items match")
        return 0

    for k in targets:
        print(f"  {k}\n      attempts={items[k].get('attempts')} error={str(items[k].get('error'))[:140]}")

    if not args.yes:
        print(f"\n{len(targets)} item(s) would be reopened — rerun with --yes to apply")
        return 0

    shutil.copy2(STATE, STATE + ".bak.reopen")
    for k in targets:
        rec = items[k]
        rec["status"] = "pending"
        rec["attempts"] = 0
        # A recorded job/submission id belongs to the rejected text; keeping it
        # would only replay the same dead verdict.
        for f in ("error", "job_id", "job_src", "submission_id", "submission_src"):
            rec.pop(f, None)
    tmp = STATE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(st, f)
    os.replace(tmp, STATE)
    print(f"reopened {len(targets)} item(s); backup at {os.path.basename(STATE)}.bak.reopen")
    return 0


if __name__ == "__main__":
    sys.exit(main())
