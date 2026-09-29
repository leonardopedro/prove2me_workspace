#!/usr/bin/env python3
"""Publish-order check for def bundles: what must be published before what.

The platform compiles a def bundle against ONLY the definitions already
published (runbook §2), so `import Definitions.Def_X` fails server-side when X
was never published — even though it compiles locally.  This walks the local
`import Definitions.Def_*` graph and reports, deps-first, every bundle in a
target's closure that the platform does not have yet.

Usage:
  python3 debug/def_closure.py --target ChapterSqSumFarisLavine
  python3 debug/def_closure.py --wave        # every wave def vs. the platform
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def local_imports(path):
    try:
        txt = open(path, encoding="utf-8").read()
    except OSError:
        return []
    return [m[len("Definitions.Def_"):] for m in
            re.findall(r"(?m)^import\s+(Definitions\.Def_\S+)", txt)]


def closure(target, defs):
    """(order, missing_files): deps-first closure of `target` over def bundles."""
    order, seen, missing = [], set(), []

    def visit(chapter):
        if chapter in seen:
            return
        seen.add(chapter)
        meta = defs.get(chapter)
        path = up.resolve_path(meta["file"]) if meta else os.path.join(
            WS, "Definitions", f"Def_{chapter}.lean")
        if not os.path.exists(path):
            missing.append(chapter)
            return
        for dep in local_imports(path):
            if dep != chapter:
                visit(dep)
        order.append(chapter)

    visit(target)
    return order, missing


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--target", action="append", default=[],
                    help="def bundle (chapter name) to check; repeatable")
    ap.add_argument("--wave", action="store_true", help="check every wave def")
    args = ap.parse_args()

    ok, _, detail = up.auth_probe()
    if not ok:
        print(f"auth failed: {detail}")
        return 2
    jobs = up.platform_jobs()
    published = {n for n, j in jobs.items()
                 if j.get("kind") == "definition" and j.get("status") == "PUBLISHED"}
    failed = {n: j.get("error_message", "")[:120] for n, j in jobs.items()
              if j.get("kind") == "definition" and j.get("status") == "FAILED"}
    print(f"platform: {len(published)} published definition node(s), {len(failed)} failed")

    defs = up.WAVE_DEFS
    targets = list(args.target)
    if args.wave:
        targets += [c for c in defs if c not in published]
    if not targets:
        print("nothing to check (pass --target or --wave)")
        return 0

    for t in dict.fromkeys(targets):
        order, miss_files = closure(t, defs)
        unpublished = [c for c in order if c not in published]
        state = "PUBLISHED" if t in published else ("FAILED" if t in failed else "absent")
        print(f"\n{t}: {state}"
              + (f"  (in wave spec: {t in defs})" if t not in published else ""))
        if t in failed:
            print(f"    server error: {failed[t]}")
        if miss_files:
            print(f"    ** local source missing: {', '.join(miss_files)}")
        if unpublished:
            print(f"    must publish first ({len(unpublished)}), deps-first:")
            for c in unpublished:
                tag = "in wave spec" if c in defs else "NOT IN WAVE SPEC"
                print(f"      - {c}  [{tag}]")
        else:
            print("    closure satisfied on the platform")
    return 0


if __name__ == "__main__":
    sys.exit(main())
