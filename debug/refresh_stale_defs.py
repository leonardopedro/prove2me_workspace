#!/usr/bin/env python3
"""Recompile mirror def bundles whose source has moved on since the olean.

The candidate mirror (state/mirror) is a snapshot: `regate_bundles.py` stages the
bundle it is grading but not the bundles that bundle *imports*.  When a
dependency's source changed after the mirror was built, the gate compiles the
target against the dependency's **old** olean and reports errors that the source
no longer has -- most visibly `... has already been declared`, because the stale
olean still carries declarations a repair moved elsewhere
(`Def_ChapterLeafGaps` re-carrying `ShiftHamiltonian.ShiftData.conj_mul_hFun`,
the pre-slimming theorem stubs still carrying whole chapter bodies).

Usage:
    python3 debug/refresh_stale_defs.py --files /tmp/rebuild_order.txt
    python3 debug/refresh_stale_defs.py --from-failures

`--from-failures` takes every failing bundle in state/def_gate.json, walks its
import closure, and rebuilds the def modules whose mirror copy differs from the
repo copy (plus the failing bundles themselves).  One compile at a time: two
concurrent `lean` processes on a long bundle are what triggered the OOM killer
(15 GB machine, 2026-10-28).
"""
import argparse
import json
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"


def lean_path():
    return subprocess.run(["lake", "env", "bash", "-c", 'printf %s "$LEAN_PATH"'],
                          cwd=PROJ, capture_output=True, text=True).stdout.strip()


def imports(p):
    if not os.path.exists(p):
        return []
    t = open(p, encoding="utf-8", errors="ignore").read()
    return re.findall(r"^import (Definitions|Theorems)\.(\S+)", t, re.M)


def closure(start):
    seen, stack = set(), list(start)
    while stack:
        p = stack.pop()
        if p in seen or not os.path.exists(p):
            continue
        seen.add(p)
        for root, m in imports(p):
            stack.append(f"{root}/{m}.lean")
    return seen


def differs(a, b):
    try:
        return open(a, "rb").read() != open(b, "rb").read()
    except OSError:
        return True


def stale_targets():
    gate = json.load(open(os.path.join(WS, "state", "def_gate.json")))
    fails = [f"Definitions/Def_{k}.lean" for k, v in gate.items()
             if isinstance(v, dict) and str(v.get("status", "")).startswith("FAIL")]
    closure_of = closure(fails)
    need = set(fails)
    for p in closure_of:
        if p.startswith("Theorems/"):
            continue
        if differs(os.path.join(WS, p), os.path.join(MIRROR, p)):
            need.add(p)
    return sorted(need)


def topo(need):
    order, mark = [], {}

    def visit(p):
        if mark.get(p):
            return
        mark[p] = 1
        for root, m in imports(os.path.join(WS, p)):
            d = f"{root}/{m}.lean"
            if d in need:
                visit(d)
        order.append(p)
        mark[p] = 2

    for p in sorted(need):
        visit(p)
    return order


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--files", help="list of modules to rebuild, one path per line")
    ap.add_argument("--from-failures", action="store_true",
                    help="rebuild the stale deps of every failing bundle")
    a = ap.parse_args()
    if a.files:
        need = {l.strip() for l in open(a.files) if l.strip()}
    elif a.from_failures:
        need = set(stale_targets())
    else:
        print("give --files or --from-failures")
        return 2
    order = topo(need)
    print(f"{len(order)} modules to rebuild", flush=True)

    base = lean_path()
    env = dict(os.environ, LEAN_PATH=f"{MIRROR}:{base}",
               PATH=PATH_BIN + ":" + os.environ["PATH"])
    lean = subprocess.run(["bash", "-c", "command -v lean"], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()
    ok = fail = 0
    for p in order:
        src = os.path.join(WS, p)
        dst = os.path.join(MIRROR, p)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        open(dst, "w").write(open(src, encoding="utf-8", errors="ignore").read())
        module = p[:-5]
        r = subprocess.run([lean, "-DautoImplicit=false", "-o", module + ".olean",
                            module + ".lean"],
                           cwd=MIRROR, env=env, capture_output=True, text=True,
                           timeout=int(os.environ.get("REGATE_TIMEOUT", "1800")))
        if r.returncode == 0:
            ok += 1
            print(f"OK   {p}", flush=True)
        else:
            fail += 1
            err = next((l for l in (r.stdout + r.stderr).splitlines() if "error" in l), "")
            print(f"FAIL {p}  {err.strip()[:200]}", flush=True)
    print(f"\n{ok} rebuilt, {fail} still failing", flush=True)
    return 0 if fail == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
