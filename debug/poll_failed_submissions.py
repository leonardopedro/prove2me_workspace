#!/usr/bin/env python3
"""Find OUR failed sol submissions on the platform (read-only).

PIPELINE_PLAN §2.30b: the ledger only remembers the LAST attempt per item, so
theorems whose early sol submissions FAILED (and were never retried successfully)
look `pending`/`done` locally while the platform still shows a red FAILED
submission.  This tool asks the platform directly: for every theorem WE
published (thm ledger done -> theorem_id), list submissions with a
non-accepted status that were created by our user, and write a report:

    state/failed_submissions.json
        {"<slug>": {"theorem_id":..., "submissions":[{"id","status",
                     "error_message","created_at"}]}}
    /tmp/failed_submission_slugs.txt   one slug per line (fix queue)

Usage:  python3 debug/poll_failed_submissions.py [--workers 12] [--limit 0]
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

BAD = "FAILED,CE,WA,ERROR,SORRY"


def one(args):
    slug, tid = args
    try:
        r = up.api("GET", f"theorems/{tid}/submissions",
                   params={"status": BAD, "limit": 200}) or {}
    except Exception as e:
        return slug, {"error": f"API {str(e)[:120]}"}
    subs = [s for s in (r.get("submissions") or [])
            if s.get("username") == up.me_username]
    if not subs:
        return slug, None
    return slug, {"theorem_id": tid,
                  "submissions": [{"id": s.get("id"),
                                   "status": s.get("status"),
                                   "error_message": (s.get("error_message") or "")[:400],
                                   "created_at": s.get("created_at")}
                                  for s in subs]}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--workers", type=int, default=12)
    ap.add_argument("--limit", type=int, default=0)
    args = ap.parse_args()
    ok, version, detail = up.auth_probe()
    if not ok:
        print(f"platform access: FAILED {detail}")
        return 2
    me = up.api("GET", "me") or {}
    up.me_username = me.get("username")
    st = json.load(open(f"{WS}/state/pipeline.json"))["items"]
    targets = [(k[4:], v["theorem_id"])
               for k, v in st.items()
               if k.startswith("thm:") and v.get("status") == "done"
               and v.get("theorem_id")]
    if args.limit:
        targets = targets[:args.limit]
    print(f"our username: {up.me_username}; sweeping {len(targets)} published theorem(s)")
    out = {}
    with concurrent.futures.ThreadPoolExecutor(args.workers) as ex:
        for i, (slug, res) in enumerate(ex.map(one, targets), 1):
            if res:
                out[slug] = res
            if i % 500 == 0:
                print(f"  {i}/{len(targets)}  hits={len(out)}", flush=True)
    path = f"{WS}/state/failed_submissions.json"
    json.dump(out, open(path, "w"), indent=1, sort_keys=True)
    c = Counter(s["status"] for v in out.values() for s in v["submissions"])
    print(f"theorems with our FAILED submissions: {len(out)}  -> {path}")
    print("status breakdown:", dict(c.most_common()))
    with open("/tmp/failed_submission_slugs.txt", "w") as fh:
        for s in sorted(out):
            fh.write(s + "\n")
    for s in sorted(out)[:15]:
        sub = out[s]["submissions"][0]
        print(f"  {s[:70]} [{sub['status']}] {sub['error_message'][:90]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
