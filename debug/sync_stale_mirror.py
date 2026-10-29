"""Sync stale Definitions (WS != mirror) into the candidate mirror and rebuild.

The mirror's Def copies go stale whenever a file is edited but not re-gated
(regate only stages the *target* file). Targets then compile against old
upstream oleans -> unknown-identifier / duplicate-decl ghosts. This script:

  1. diffs WS vs mirror for Definitions/*.lean (and Theorems/*.lean),
  2. stages the WS copy of every stale module,
  3. recompiles them in topological (import) order,
  4. restores BOTH the old .lean and old .olean if a rebuild fails, so the
     mirror never ends up with a .lean that its .olean disagrees with.

Usage: python3 debug/sync_stale_mirror.py [--scope closure-of-fails] [--limit N]
"""
import argparse
import collections
import json
import os
import re
import shutil
import subprocess
import sys
import time
from collections import deque

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state/mirror"))
PROJ = os.environ.get("TIMEPIECE_PROJ",
                      "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331")
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
BAK = os.path.join(WS, "state", "scratch", "mirror_stale_bak")


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def imports_of(path, prefix):
    try:
        t = open(path, encoding="utf-8", errors="ignore").read()
    except OSError:
        return []
    return re.findall(rf"^import {re.escape(prefix)}\.(\S+)", t, re.M)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--scope", choices=["all", "closure-of-fails"], default="all")
    ap.add_argument("--defs-only", action="store_true",
                    help="skip Theorems/* (mirror Thm stubs are staged by regate "
                         "on demand; absence there is by design)")
    ap.add_argument("--limit", type=int, default=0)
    a = ap.parse_args()

    deps = {}
    for d in ("Definitions", "Theorems"):
        for f in os.listdir(os.path.join(WS, d)):
            if not f.endswith(".lean"):
                continue
            key = f"{d}/{f[:-5]}"
            deps[key] = [f"Definitions/{m}" for m in
                         imports_of(os.path.join(WS, d, f), "Definitions")] + \
                        [f"Theorems/{m}" for m in
                         imports_of(os.path.join(WS, d, f), "Theorems")]

    stale = []
    for d in (["Definitions"] if a.defs_only else ["Definitions", "Theorems"]):
        for f in os.listdir(os.path.join(WS, d)):
            if not f.endswith(".lean"):
                continue
            key = f"{d}/{f[:-5]}"
            ws = os.path.join(WS, d, f)
            mi = os.path.join(MIRROR, d, f)
            try:
                same = open(ws, "rb").read() == open(mi, "rb").read()
            except OSError:
                same = False
            if not same:
                stale.append(key)

    if a.scope == "closure-of-fails":
        gate = json.load(open(os.path.join(WS, "state", "def_gate.json")))
        fails = ["Definitions/Def_" + k for k, v in gate.items()
                 if isinstance(v, dict) and (v.get("status") or "").startswith("FAIL")
                 and not k.startswith("_")]
        seen, q = set(fails), deque(fails)
        while q:
            v = q.popleft()
            for w in deps.get(v, ()):
                if w not in seen:
                    seen.add(w); q.append(w)
        stale = [s for s in stale if s in seen]

    stale_set = set(stale)
    print(f"stale modules in scope: {len(stale)}", flush=True)
    if a.limit:
        stale = stale[:a.limit]

    order, seen, stack = [], set(), set()

    def visit(m):
        if m in seen or m in stack:
            return
        stack.add(m)
        for d in deps.get(m, []):
            if d in stale_set:
                visit(d)
        stack.discard(m)
        seen.add(m)
        order.append(m)

    for m in sorted(stale):
        visit(m)
    print(f"rebuild order: {len(order)}", flush=True)

    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ.get("PATH", ""))
    os.makedirs(BAK, exist_ok=True)

    ok = fail = restored = 0
    for i, key in enumerate(order, 1):
        d, name = key.split("/")
        src = os.path.join(WS, d, f"{name}.lean")
        dst = os.path.join(MIRROR, d, f"{name}.lean")
        olean = os.path.join(MIRROR, d, f"{name}.olean")
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        # stage WS copy (keep old .lean + .olean aside for restore)
        bak_lean = os.path.join(BAK, f"{d}__{name}.lean")
        bak_olean = bak_lean + "lean.bakolean".replace("lean.bakolean", ".olean")
        if os.path.exists(dst) and not os.path.exists(bak_lean):
            shutil.copy2(dst, bak_lean)
        if os.path.exists(olean) and not os.path.exists(bak_olean):
            shutil.copy2(olean, bak_olean)
        shutil.copy2(src, dst)
        # stage the module's Thm imports too (regate does this for targets;
        # a sync-rebuilt Def must see the same Thm oleans a target would)
        if d == "Definitions":
            for m in imports_of(src, "Theorems"):
                tsrc, tdst = os.path.join(WS, "Theorems", f"{m}.lean"), \
                    os.path.join(MIRROR, "Theorems", f"{m}.lean")
                tolean = tdst[:-5] + ".olean"
                if os.path.exists(tsrc):
                    os.makedirs(os.path.dirname(tdst), exist_ok=True)
                    shutil.copy2(tsrc, tdst)
                if os.path.exists(tsrc) and not os.path.exists(tolean):
                    subprocess.run(
                        [lean, "-DautoImplicit=false", "-o", f"Theorems/{m}.olean",
                         f"Theorems/{m}.lean"],
                        cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                        capture_output=True, text=True, timeout=600)
        if os.path.exists(olean):
            os.remove(olean)  # force rebuild; lean -o writes on success
        t0 = time.time()
        try:
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o", f"{d}/{name}.olean",
                 f"{d}/{name}.lean"],
                cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                capture_output=True, text=True, timeout=600)
            out = r.stdout + r.stderr
            bad = r.returncode != 0
        except subprocess.TimeoutExpired:
            out, bad = "TIMEOUT", True
        if bad:
            fail += 1
            first = next((l for l in out.splitlines() if "error" in l), out[:200])
            print(f"[{i}/{len(order)}] FAIL {key}: {first[:200]}", flush=True)
            # restore old .lean + .olean so the mirror stays consistent
            if os.path.exists(bak_lean):
                shutil.copy2(bak_lean, dst)
            if os.path.exists(bak_olean):
                shutil.copy2(bak_olean, olean)
                restored += 1
            logdir = os.path.join(WS, "state", "scratch", "sync_stale_logs")
            os.makedirs(logdir, exist_ok=True)
            open(os.path.join(logdir, f"{name}.log"), "w").write(out)
        else:
            ok += 1
            print(f"[{i}/{len(order)}] ok   {key} ({time.time()-t0:.1f}s)", flush=True)
    print(f"SYNC DONE ok={ok} fail={fail} oleans_restored={restored}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
