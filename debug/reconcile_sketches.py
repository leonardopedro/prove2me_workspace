#!/usr/bin/env python3
"""Re-read every locally-recorded SKETCH and mark the ones the platform proved.

A sketch is accepted when the proof reduces to child statements that are not
`Proved` yet; the platform flips the node to `Proved` on its own once the last
child lands (measured on `FockStatistics.fermionicFock_symmetricOn_inc`, and on
47 `CarlemanGeneralHop`/`CarlemanSimplex` records).  `--sync` only re-checks
items that are still `pending`, so those flips never reach the ledger and
`--status` keeps reporting `N done sol(s) are SKETCH`.

This walks the `verdict == "SKETCH_ACCEPTED"` records, reads the node's status
from the platform, and marks the Proved ones. Nothing is inferred: an item whose
node is still `Open` stays a sketch.

Usage:
  python3 debug/reconcile_sketches.py [--dry-run]
"""
import argparse
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

LEDGER = os.path.join(WS, "state", "pipeline.json")
WAVE = os.path.join(WS, "pipeline", "wave_upload.json")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()
    led = json.load(open(LEDGER, encoding="utf-8"))
    wave = json.load(open(WAVE, encoding="utf-8"))["thms"]
    jobs = up.platform_jobs()
    sketches = [k for k, v in led["items"].items()
                if k.startswith("sol:") and v.get("verdict") == "SKETCH_ACCEPTED"]
    print("%d recorded sketch(es)" % len(sketches))
    flipped = still = missing = 0
    for k in sketches:
        slug = k[4:]
        ent = wave.get(slug)
        if not ent:
            missing += 1
            continue
        tid = (jobs.get(ent["name"]) or {}).get("theorem_id")
        if not tid:
            missing += 1
            continue
        rec = led["items"][k]
        if rec.get("node_status") == "Proved":
            still += 1
            continue
        d = up.api("GET", "theorems/%s" % tid) or {}
        st = d.get("status")
        if st == "Proved":
            if not a.dry_run:
                rec["verdict"] = "ACCEPTED"
                rec["proved"] = True
                rec["node_status"] = "Proved"
                rec.pop("open_children", None)
                rec.pop("sketch", None)
                trec = led["items"].get("thm:" + slug)
                if trec is not None:
                    trec["status"] = "done"
            flipped += 1
        else:
            still += 1
    if not a.dry_run and flipped:
        json.dump(led, open(LEDGER, "w", encoding="utf-8"), separators=(",", ":"))
    print("%s %d proved, %d still sketch, %d without a node"
          % ("would mark" if a.dry_run else "marked", flipped, still, missing))
    return 0


if __name__ == "__main__":
    sys.exit(main())
