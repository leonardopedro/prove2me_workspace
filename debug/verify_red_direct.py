#!/usr/bin/env python3
"""Direct-compile sols against the on-disk mirror and record fresh verdicts.

`check_red_sols.py` verdicts a whole batch in a SHARED temp dir, so one failed
statement-module build leaks `object file ... does not exist` onto unrelated sols
(observed: a fiberCore_dense verdict naming an unrelated StrichartzWave module).
That artifact is why 74 already-fixed reds never became resubmit candidates.

This tool compiles each sol on its OWN against `state/mirror` (LEAN_PATH =
mirror : timepiece331 base, so Mathlib .leans are reused, no rebuild) and writes
the real per-sol verdict into state/offline_pending_check.json, which the
submission guard and resubmit_ok_red read like any other.

Usage:
  python3 debug/verify_red_direct.py --input list.txt [--jobs 4]
  ... --merge-only # just print, do not write
"""
import argparse
import concurrent.futures
import json
import os
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("DEF_MIRROR", f"{WS}/state/mirror")
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(os.path.dirname(WS), "timepiece331"))
OUT = f"{WS}/state/offline_pending_check.json"


def lean_env():
    def lake(cmd):
        return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                              capture_output=True, text=True).stdout.strip()
    lean = lake("command -v lean")
    base = lake('printf %s "$LEAN_PATH"')
    return lean, f"{MIRROR}:{base}"


def compile_one(args):
    lean, env_path, slug = args
    path = f"{WS}/Solutions/Sol_{slug}.lean"
    if not os.path.exists(path):
        return slug, "NOFILE"
    env = dict(os.environ, LEAN_PATH=env_path)
    try:
        r = subprocess.run([lean, "-DautoImplicit=false", path], env=env,
                           capture_output=True, text=True, timeout=300)
    except subprocess.TimeoutExpired:
        return slug, "TIMEOUT"
    if r.returncode == 0:
        return slug, "ok"
    out = (r.stdout + r.stderr).strip().splitlines()
    err = next((l for l in out if "error" in l), "compile error")
    return slug, "FAIL:" + err.strip().replace("\t", " ")[:300]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", default="state/scratch/red_fixable_pub.txt")
    ap.add_argument("--jobs", type=int, default=4)
    ap.add_argument("--merge-only", action="store_true")
    a = ap.parse_args()
    names = [l.strip() for l in open(a.input) if l.strip()]
    lean, env_path = lean_env()
    if not lean:
        print("could not resolve lean"); return 2
    print(f"direct-compiling {len(names)} sol(s) against {MIRROR} (jobs={a.jobs})", flush=True)
    res = {}
    with concurrent.futures.ThreadPoolExecutor(a.jobs) as ex:
        for i, (slug, v) in enumerate(ex.map(
                lambda s: compile_one((lean, env_path, s)), names), 1):
            res[slug] = v
            if i % 20 == 0:
                ok = sum(1 for x in res.values() if x == "ok")
                print(f"  {i}/{len(names)}  ok={ok}", flush=True)
    ok = sorted(s for s, v in res.items() if v == "ok")
    fail = {s: v for s, v in res.items() if v != "ok"}
    print(f"\nok={len(ok)}  fail={len(fail)}")
    # merge fresh verdicts (only within this input's scope; others survive)
    try:
        fresh = json.load(open(OUT))
        if not isinstance(fresh, dict):
            fresh = {}
    except (OSError, ValueError):
        fresh = {}
    sol = dict((fresh.get("sol") or {}).get("items", {}))
    sol.update(res)
    fresh["sol"] = {"items": sol,
                    "statement_modules": (fresh.get("sol") or {}).get("statement_modules", {}) or {}}
    if not a.merge_only:
        tmp = OUT + ".tmp"
        with open(tmp, "w") as fh:
            json.dump(fresh, fh, indent=1)
        os.replace(tmp, OUT)
        print(f"merged verdicts into {OUT}")
    else:
        print("(merge-only: not written)")
    open(f"{WS}/state/scratch/red_direct_ok.txt", "w").write("\n".join(ok) + ("\n" if ok else ""))
    from collections import Counter
    c = Counter(v.split(":")[0] if v != "ok" else "ok" for v in res.values())
    print("fail kinds:", dict(c))
    for s, v in list(fail.items())[:8]:
        print(f"  {s}: {v[:120]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
