#!/usr/bin/env python3
"""Mark pipeline items the platform already holds as done, from recorded errors.

The publish catalogue and the plan can disagree in both directions. A chapter
published in an earlier session shows up as `pending` here, and re-submitting it
is rejected with

    submit-definition rejected: {"error": "A theorem or definition with name
    \"ChapterX\" already exists"}

That rejection spends one of the item's 5 attempts and, once the cap is hit,
makes the item permanently un-runnable -- for a node that has been published all
along. `--sync` cannot repair it: `sync_state` only walks `ORDER` looking for
items the platform holds, and it never inspects a failure reason.

So read the recorded `error` of every failed/pending item and, when the platform
says the name is taken, record it as done. Re-running this is safe and cheap: it
only ever moves an item to `done` when the platform has explicitly said the name
already exists.

    python3 debug/reconcile_duplicates.py [--dry-run]
"""
import argparse
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(WS, "state", "pipeline.json")

TAKEN = re.compile(r"with name [\"']([^\"']+)[\"'] already exists")
TAKEN_ALT = re.compile(r"already exists", re.I)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    with open(STATE, encoding="utf-8") as f:
        st = json.load(f)
    items = st.setdefault("items", {})

    hits = []
    for item, rec in items.items():
        if not isinstance(rec, dict):
            continue
        if rec.get("status") == "done":
            continue
        err = rec.get("error") or ""
        if not err or not TAKEN_ALT.search(err):
            continue
        m = TAKEN.search(err)
        name = m.group(1) if m else item.partition(":")[2]
        hits.append((item, name))

    for item, name in hits:
        print(f"  {item:72s} already published as {name}")
    print(f"{len(hits)} item(s) the platform already holds")

    if args.dry_run or not hits:
        return 0

    for item, name in hits:
        items[item] = {
            "status": "done",
            "reused": True,
            "skipped": "platform reports the name already exists",
            "platform_name": name,
        }
    tmp = STATE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(st, f)
    os.replace(tmp, STATE)
    print(f"marked {len(hits)} item(s) done")
    return 0


if __name__ == "__main__":
    sys.exit(main())