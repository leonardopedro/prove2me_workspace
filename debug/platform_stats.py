#!/usr/bin/env python3
"""Print honest platform counters (/me) alongside the local plan-state breakdown.

Usage: PROVE2ME_API_KEY=... python3 debug/platform_stats.py
"""
import collections
import json
import os
import subprocess
import sys

API = "https://prove2.me/api/v1"
WS = os.environ.get("PROVE2ME_WS") or os.getcwd()


def key():
    k = (os.environ.get("PROVE2ME_API_KEY") or "").strip()
    if k:
        return k
    with open(os.path.join(WS, "credentials.json")) as f:
        return json.load(f)["api_key"]


def api(endpoint, token):
    out = subprocess.run(
        ["curl", "-s", "-H", f"Authorization: Bearer {token}", f"{API}/{endpoint}"],
        capture_output=True, text=True, timeout=60).stdout
    return json.loads(out)


def main():
    tok = json.loads(subprocess.run(
        ["curl", "-s", "-X", "POST", f"{API}/agent/refresh",
         "-H", "Content-Type: application/json",
         "-d", json.dumps({"api_key": key()})],
        capture_output=True, text=True, timeout=30).stdout)["access_token"]

    me = api("me", tok)
    print("=== platform /me ===")
    for k in ("username", "num_solved_prob", "num_submitted_prob", "trust_score"):
        if k in me:
            print(f"  {k}: {me[k]}")

    st = json.load(open(os.path.join(WS, "state/pipeline.json")))["items"]
    c = collections.Counter(v.get("status") for v in st.values() if isinstance(v, dict))
    print("\n=== local plan state ===")
    for k, v in c.most_common():
        print(f"  {k}: {v}")

    kinds = collections.Counter()
    for k, v in st.items():
        if isinstance(v, dict) and v.get("status") == "done":
            kinds[k.split(":", 1)[0]] += 1
    print("\n=== done by kind ===")
    for k, v in kinds.most_common():
        print(f"  {k}: {v}")

    failed = [k for k, v in st.items() if isinstance(v, dict) and v.get("status") == "failed"]
    print(f"\n=== failed ({len(failed)}) ===")
    for k in sorted(failed):
        print(f"  {k}")


if __name__ == "__main__":
    sys.exit(main())
