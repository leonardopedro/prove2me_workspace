#!/usr/bin/env python3
"""List definition publish jobs by status (which def bundles actually published).

Usage: python3 debug/def_jobs.py [--status FAILED] [--grep SUBSTR]
"""
import argparse
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
    return json.load(open(os.path.join(WS, "credentials.json")))["api_key"]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--status", default="FAILED")
    ap.add_argument("--grep", default="")
    a = ap.parse_args()

    tok = json.loads(subprocess.run(
        ["curl", "-s", "-X", "POST", f"{API}/agent/refresh",
         "-H", "Content-Type: application/json", "-d", json.dumps({"api_key": key()})],
        capture_output=True, text=True, timeout=30).stdout)["access_token"]

    jobs, offset = [], 0
    while True:
        out = subprocess.run(
            ["curl", "-s", "-G", "-H", f"Authorization: Bearer {tok}",
             "--data-urlencode", "kind=definition",
             "--data-urlencode", "limit=100",
             "--data-urlencode", f"offset={offset}", f"{API}/publish-jobs"],
            capture_output=True, text=True, timeout=60).stdout
        page = json.loads(out)
        arr = next((v for v in page.values() if isinstance(v, list)), [])
        if not arr:
            break
        jobs += arr
        offset += len(arr)

    sel = [j for j in jobs if j.get("status") == a.status and a.grep in json.dumps(j)]
    print(f"{len(sel)}/{len(jobs)} jobs with status {a.status}")
    for j in sel:
        name = (j.get("theorem_name") or j.get("module_name") or j.get("name")
                or j.get("title") or j.get("id"))
        err = (j.get("error") or j.get("message") or "").replace("\n", " ")[:90]
        print(f"  {name}  | {err}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
