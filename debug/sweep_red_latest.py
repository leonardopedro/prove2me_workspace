#!/usr/bin/env python3
"""True-red sweep: for every theorem WE published, keep the slug only when its
LATEST submission (by created_at, any status) is not ACCEPTED.

`poll_failed_submissions.py` collects every historical FAILED submission, so a
slug that failed once and was later accepted still appears in
state/failed_submissions.json (observed: 39/40 of the var-name family were in
fact ACCEPTED on the platform).  This tool asks for the submission list without
a status filter and compares the newest entry, giving the real red set:

    state/red_latest.json     {slug: {theorem_id, latest: {status,error,created_at}}}
    /tmp/red_latest_slugs.txt one slug per line

Usage:  python3 debug/sweep_red_latest.py [--workers 12] [--limit 0]
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


def one(args):
    slug, tid = args
    try:
        r = up.api("GET", f"theorems/{tid}/submissions",
                   params={"limit": 200}) or {}
    except Exception as e:
        return slug, {"error": f"API {str(e)[:120]}"}
    subs = [s for s in (r.get("submissions") or [])
            if s.get("username") == up.me_username]
    if not subs:
        return slug, None
    subs.sort(key=lambda s: s.get("created_at") or "")
    latest = subs[-1]
    if latest.get("status") in ("ACCEPTED", "SKETCH_ACCEPTED", "Proved"):
        return slug, None
    return slug, {"theorem_id": tid,
                  "latest": {"id": latest.get("id"),
                             "status": latest.get("status"),
                             "error_message": (latest.get("error_message") or "")[:400],
                             "created_at": latest.get("created_at")},
                  "n_submissions": len(subs)}


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
            if res and "latest" in res:
                out[slug] = res
            if i % 500 == 0:
                print(f"  {i}/{len(targets)}  true-red={len(out)}", flush=True)
    path = f"{WS}/state/red_latest.json"
    tmp = path + ".tmp"
    json.dump(out, open(tmp, "w"), indent=1, sort_keys=True)
    os.replace(tmp, path)
    c = Counter(v["latest"]["status"] for v in out.values())
    print(f"true-red sols: {len(out)}  -> {path}")
    print("latest-status breakdown:", dict(c.most_common()))
    with open("/tmp/red_latest_slugs.txt", "w") as fh:
        for s in sorted(out):
            fh.write(s + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
