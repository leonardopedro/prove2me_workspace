#!/usr/bin/env python3
"""Print the FULL error text of definition publish jobs.

The pipeline log clips verdicts at ~200 chars, which hides the second half of an
elaboration error (the "but is expected to have type" part). The publish-job
record keeps the whole thing, so read it from there.

    PROVE2ME_WS=/home/daytona/codebase python3 debug/probe_publish_jobs.py \
        [--kind definition|problem] [--limit 5] [--match ChapterFullQuadraticEsa]
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(HERE), "pipeline"))
sys.path.insert(0, os.path.dirname(HERE))

import upload_pipeline as up  # noqa: E402


def error_text(job):
    for key in ("error", "error_message", "detail", "message", "failure_reason",
                "result", "log", "output"):
        v = job.get(key)
        if isinstance(v, str) and v.strip():
            return v
        if isinstance(v, dict):
            inner = error_text(v)
            if inner:
                return inner
    return ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--kind", default="definition")
    ap.add_argument("--limit", type=int, default=5)
    ap.add_argument("--match", default="")
    a = ap.parse_args()

    jobs = up._paged("publish-jobs", {"kind": a.kind})
    if not jobs:
        print("no jobs returned")
    print(f"{len(jobs)} {a.kind} job(s)")
    if jobs:
        print("job keys:", sorted(jobs[0].keys()))
    n = 0
    for j in jobs:
        blob = str(j)
        if a.match and a.match not in blob:
            continue
        err = error_text(j)
        if not err:
            continue
        print("=" * 78)
        print({k: j.get(k) for k in ("id", "kind", "status", "created_at", "updated_at")
               if k in j})
        print(err)
        n += 1
        if n >= a.limit:
            break
    print(f"--- printed {n} error(s) ---")


if __name__ == "__main__":
    main()
