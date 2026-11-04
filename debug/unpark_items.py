#!/usr/bin/env python3
"""Reopen items the runner marked `parked`, when the verdict behind the park is wrong.

`debug/park_dup_thms.py` parks an item when `blocked_by` reports
"target name already declared by published def bundle X".  That verdict is taken
from the *platform*, but the park decision is taken from the string, and the
string can be produced by a docstring: `Def_ChapterQuadraticFockEsa` mentions
`dGamma_hermCol_essentiallySelfAdjointOn_core` and
`dGamma_fqPoly_essentiallySelfAdjointOn_core` in its module docstring and
declares neither, so both theorem items were parked (and their sols with them)
although `GET /theorems?q=<name>` returns nothing for either.

Nothing else in `debug/` reopens `status == "parked"`: `reopen_failed.py` selects
`failed` or `attempts >= MAX_ATTEMPTS`, and a parked duplicate has
`attempts == 0`.

Usage:
    python3 debug/unpark_items.py --only QuadFockEsa_dGamma      # list
    python3 debug/unpark_items.py --only QuadFockEsa_dGamma --apply

Single-writer: refuses to write while an `upload_pipeline.py` process is alive,
because that process rewrites the same state file.
"""
import argparse
import json
import os
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(WS, "state", "pipeline.json")


def runner_alive():
    try:
        out = subprocess.run(["pgrep", "-f", r"[u]pload_pipeline\.py"],
                             capture_output=True, text=True).stdout
    except OSError:
        return False
    return bool(out.strip())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", action="append", default=[],
                    help="substring of the item key (repeatable)")
    ap.add_argument("--apply", action="store_true", help="write the changes")
    ap.add_argument("--force", action="store_true",
                    help="write even while the runner is alive (not advised)")
    a = ap.parse_args()
    if not a.only:
        ap.error("give at least one --only SUBSTR")

    st = json.load(open(STATE, encoding="utf-8"))
    items = st.get("items", {})
    hit = [k for k, rec in items.items()
           if rec.get("status") == "parked"
           and any(o in k for o in a.only)]
    if not hit:
        print("no parked items match")
        return 0

    for k in hit:
        rec = items[k]
        print(f"{k}\n    parked because: {rec.get('error')}")
    if not a.apply:
        print(f"\n{len(hit)} item(s); rerun with --apply to reopen")
        return 0

    if runner_alive() and not a.force:
        print("\nrefusing to write: an upload_pipeline process is running "
              "(single-writer). Wait for the chunk to exit, or pass --force.")
        return 1

    for k in hit:
        rec = items[k]
        rec["status"] = "pending"
        rec["attempts"] = 0
        for f in ("error", "error_src"):
            rec.pop(f, None)
    tmp = STATE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as fh:
        json.dump(st, fh)
    os.replace(tmp, STATE)
    print(f"reopened {len(hit)} item(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
