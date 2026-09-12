#!/usr/bin/env python3
"""Print raw platform response shapes (read-only) to pin down endpoint drift.

Used when the skill version and the platform version differ (SKILL.md's version
self-check): a changed envelope silently yields empty lists in the uploader's
pagination helper, so inspect the raw JSON before trusting a zero.

Usage: python3 debug/api_probe.py
"""
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def show(label, value, width=600):
    if isinstance(value, dict):
        print(f"{label}: dict keys={list(value.keys())}")
        body = json.dumps(value)[:width]
    elif isinstance(value, list):
        print(f"{label}: list len={len(value)}")
        body = json.dumps(value[:2])[:width]
    else:
        body = json.dumps(value)[:width]
    print(f"    {body}")


def main():
    ok, version, detail = up.auth_probe()
    print(f"auth ok={ok} platform_version={version} {detail}")
    if not ok:
        return 2
    for label, endpoint, params in [
        ("GET /me", "me", None),
        ("GET /publish-jobs", "publish-jobs", None),
        ("GET /publish-jobs?kind=definition", "publish-jobs", {"kind": "definition", "limit": "5"}),
        ("GET /publish-jobs?kind=problem", "publish-jobs", {"kind": "problem", "limit": "5"}),
        ("GET /theorems?tags=timepiece", "theorems", {"tags": "timepiece", "limit": "5"}),
        ("GET /environments", "environments", None),
    ]:
        show(label, up.api("GET", endpoint, params=params))
    return 0


if __name__ == "__main__":
    sys.exit(main())
