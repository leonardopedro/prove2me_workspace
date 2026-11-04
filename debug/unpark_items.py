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

A second verdict this tool reopens: a def bundle the runner marked `done` because it
*found* a platform definition of that name (`reused: true`) and therefore never
submitted our text.  `state/published_bundles/Def_ChapterFockWeightedSchurEsa.lean`
is the 9-line generated stub "Generated def bundle for ChapterFockWeightedSchurEsa",
while the workspace bundle is 867 lines that compile against the served world — so
`BookProof.FockWeightedSchur` and, behind it, `BookProof.GradedBandSchur` do not exist
on the platform and every theorem stub that opens them fails to elaborate.
`--republish` clears the reuse record of such an item so the def chunk submits the
bundle we have.

Usage:
    python3 debug/unpark_items.py --only QuadFockEsa_dGamma      # list
    python3 debug/unpark_items.py --only QuadFockEsa_dGamma --apply
    python3 debug/unpark_items.py --republish --only ChapterFockWeightedSchur --apply

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
    ap.add_argument("--republish", action="store_true",
                    help="also reopen `done` def items that were only REUSED from a "
                         "platform definition of the same name (our text was never "
                         "submitted)")
    a = ap.parse_args()
    if not a.only:
        ap.error("give at least one --only SUBSTR")

    st = json.load(open(STATE, encoding="utf-8"))
    items = st.get("items", {})
    def reusable(k, rec):
        return (a.republish and k.startswith("def:") and rec.get("status") == "done"
                and rec.get("reused") is True)

    hit = [k for k, rec in items.items()
           if (rec.get("status") == "parked" or reusable(k, rec))
           and any(o in k for o in a.only)]
    if not hit:
        print("no parked items match")
        return 0

    for k in hit:
        rec = items[k]
        if reusable(k, rec):
            print(f"{k}\n    marked done by reuse ({rec.get('reused_status')}), def_id "
                  f"{rec.get('def_id')} — our text was never submitted")
        else:
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
        for f in ("error", "error_src", "def_id", "job_id", "reused",
                  "reused_status", "synced_from", "job_src"):
            rec.pop(f, None)
    tmp = STATE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as fh:
        json.dump(st, fh)
    os.replace(tmp, STATE)
    print(f"reopened {len(hit)} item(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
