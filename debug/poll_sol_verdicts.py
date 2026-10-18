#!/usr/bin/env python3
"""Poll every recorded sol `submission_id` in state/pipeline.json (read-only).

PIPELINE_PLAN §2.29-7: the ledger's sol `done` records a *submitted* id; a
server-rejected submission can still read `done` locally, which is one reason
published theorems outnumber accepted sols.  This tool asks the platform for the
verdict of every recorded submission and writes a report:

    state/sol_submission_verdicts.json   {"<slug>": {"status": ..., "error": ...}}

Usage:  python3 debug/poll_sol_verdicts.py [--workers 10]
"""
import argparse
import concurrent.futures
import json
import os
import sys
from collections import Counter

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def poll(slug, sid):
    try:
        p = up.api("GET", "verify", params={"submission_id": sid}) or {}
    except Exception as e:  # network hiccup must not lose the item
        return slug, {"status": "POLL_ERROR", "error": str(e)[:200]}
    return slug, {"status": p.get("status"),
                  "error": (p.get("error_message") or "")[:300]}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--workers", type=int, default=10)
    args = ap.parse_args()
    ok, version, detail = up.auth_probe()
    if not ok:
        print(f"platform access: FAILED {detail}")
        return 2
    st = json.load(open(f"{WS}/state/pipeline.json"))
    targets = [(k[4:], v["submission_id"])
               for k, v in st["items"].items()
               if k.startswith("sol:") and v.get("submission_id")]
    print(f"polling {len(targets)} submission(s)")
    out = {}
    with concurrent.futures.ThreadPoolExecutor(args.workers) as ex:
        for i, (slug, res) in enumerate(ex.map(lambda t: poll(*t), targets), 1):
            out[slug] = res
            if i % 250 == 0:
                print(f"  {i}/{len(targets)}", flush=True)
    path = f"{WS}/state/sol_submission_verdicts.json"
    json.dump(out, open(path, "w"), indent=1, sort_keys=True)
    c = Counter(v["status"] for v in out.values())
    print("verdicts:", dict(c.most_common()))
    bad = sorted(s for s, v in out.items()
                 if v["status"] not in ("ACCEPTED", "SKETCH_ACCEPTED", "Proved"))
    print(f"non-accepted: {len(bad)}  -> {path}")
    json.dump(bad, open("/tmp/failed_sol_submissions.txt", "w"), indent=0)
    for s in bad[:20]:
        print(" ", s, out[s]["status"], out[s]["error"][:80])
    return 0


if __name__ == "__main__":
    sys.exit(main())
