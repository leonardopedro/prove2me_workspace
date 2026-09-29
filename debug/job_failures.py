#!/usr/bin/env python3
"""Group FAILED publish jobs by reason, and print the plan-vs-platform gap.

Read-only.  Answers the questions that decide whether a chunk is safe to submit
and what to submit first: (a) is there a systemic server-side failure mode, (b)
which pending plan items were never attempted vs. attempted-and-failed (with the
server's own error), (c) which def bundle is the critical path.

Usage: python3 debug/job_failures.py [--samples N] [--gap]
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def classify(msg):
    m = (msg or "").lower()
    for needle, label in [
        ("duplicate", "duplicate name (already exists)"),
        ("already exists", "duplicate name (already exists)"),
        ("timeout", "compile timeout"),
        ("unknown import", "unknown/unavailable import"),
        ("unknown identifier", "unknown identifier"),
        ("failed to fetch", "dependency fetch failure"),
        ("not proved", "imported theorem not Proved"),
        ("sorry", "sorry where none allowed"),
        ("expected", "elaboration/type error"),
        ("unexpected token", "syntax error"),
    ]:
        if needle in m:
            return label
    first = re.sub(r"\s+", " ", (msg or "").strip())[:90]
    return first or "(empty error_message)"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--samples", type=int, default=4)
    ap.add_argument("--gap", action="store_true",
                    help="also print the plan-vs-platform gap for pending items")
    args = ap.parse_args()

    ok, _, detail = up.auth_probe()
    if not ok:
        print(f"auth failed: {detail}")
        return 2
    jobs = up.platform_jobs()  # newest job per theorem_name
    kinds = {}
    for name, j in jobs.items():
        kinds.setdefault(j.get("kind"), {}).setdefault(j.get("status"), 0)
        kinds[j["kind"]][j.get("status")] = kinds[j["kind"]].get(j["status"], 0) + 1
    print("newest job per name:", json.dumps(kinds))

    for kind in ("definition", "problem"):
        failed = {n: j for n, j in jobs.items() if j.get("kind") == kind and j.get("status") == "FAILED"}
        if not failed:
            continue
        groups = {}
        for n, j in failed.items():
            groups.setdefault(classify(j.get("error_message")), []).append(n)
        print(f"\nFAILED {kind}: {len(failed)} name(s)")
        for reason, names in sorted(groups.items(), key=lambda kv: -len(kv[1])):
            print(f"  {len(names):5d}  {reason}")
            for n in names[:args.samples]:
                print(f"         e.g. {n}")

    if args.gap:
        st = up.load_state()
        st.setdefault("items", {})
        miss = up.missing_sources()
        print("\nplan-vs-platform gap (pending items only):")
        for kind, label in (("def", "defs"), ("thm", "thms"), ("sol", "sols")):
            pending = [i for i in up.ORDER if i.partition(":")[0] == kind
                       and i not in miss and st["items"].get(i, {}).get("status") != "done"]
            never = failed = 0
            reasons = {}
            for i in pending:
                name = i.partition(":")[2]
                key = name if kind == "def" else (up.WAVE_THMS.get(name) or {}).get("name", name)
                j = jobs.get(key)
                if j is None:
                    never += 1
                elif j.get("status") == "FAILED":
                    failed += 1
                    reasons.setdefault(classify(j.get("error_message")), []).append(i)
            print(f"  {label:5s} pending={len(pending):4d}  never attempted={never:4d}  "
                  f"platform-FAILED={failed:4d}")
            for reason, items in sorted(reasons.items(), key=lambda kv: -len(kv[1]))[:3]:
                print(f"       {len(items):4d}  {reason}")
                for i in items[:3]:
                    print(f"              {i}")
        p = up.plan_progress(st, miss)
        print(f"  state: {p['done']} done / {p['pending']} pending / {p['failed']} failed, "
              f"{len(miss)} unsubmittable")
    return 0


if __name__ == "__main__":
    sys.exit(main())
