#!/usr/bin/env python3
"""Build the missing oleans for a target list of modules + their dep closure.

Uses the EXACT invocation that build_published_mirror.py uses successfully
(cwd=MIRROR, `lean -o <olean> <src>`, LEAN_PATH=MIRROR:base), so the oleans are
byte-identical and the serial builder will skip them via --reuse once present.

Difference from the failed parallel_mirror_catchup: deps are built strictly
first (transitive closure, topo order) and only `jobs` workers run, so no worker
ever starts on a module whose deps are still missing (that caused the fast-fail
thundering herd). Default jobs=2 to respect the ~4GB free RAM budget.

Usage:
  python3 debug/build_target_oleans.py --targets /tmp/goals_modules.txt --jobs 2
"""
import argparse
import importlib.util
import os
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
PROJ = os.environ.get("TIMEPIECE_PROJ") or os.environ.get("PROVE2ME_PROJ") or ""
MIRROR = os.environ.get("DEF_MIRROR") or "/tmp/published_mirror"

_dm = os.path.join(HERE, "def_mirror.py")
_spec = importlib.util.spec_from_file_location("def_mirror", _dm)
dm = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(dm)


def lake_env_sh(script):
    return subprocess.run(["lake", "env", "bash", "-c", script], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def src_path(kind, name):
    folder = "Definitions" if kind == "def" else "Theorems"
    prefix = "Def_" if kind == "def" else "Thm_"
    return os.path.join(MIRROR, folder, f"{prefix}{name}.lean")


def olean_path(kind, name):
    return src_path(kind, name)[:-5] + ".olean"


def parse_target(line):
    """'Definitions.Def_X' -> ('def','X'); 'Theorems.Thm_Y' -> ('thm','Y')."""
    line = line.strip()
    if line.startswith("Definitions.Def_"):
        return ("def", line[len("Definitions.Def_"):])
    if line.startswith("Theorems.Thm_"):
        return ("thm", line[len("Theorems.Thm_"):])
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--targets", required=True)
    ap.add_argument("--jobs", type=int, default=2)
    a = ap.parse_args()

    if not PROJ:
        print("set TIMEPIECE_PROJ")
        return 2
    base_path = lake_env_sh('printf %s "$LEAN_PATH"')
    lean_bin = lake_env_sh("command -v lean")
    if not base_path or not lean_bin:
        print("could not read lean env from `lake env`")
        return 2
    env = dict(os.environ)
    env["LEAN_PATH"] = MIRROR + ":" + base_path

    targets = set()
    for line in open(a.targets):
        p = parse_target(line)
        if p:
            targets.add(p)

    # transitive dep closure over imports, restricted to modules present in mirror
    closure = set()
    stack = list(targets)
    while stack:
        k, n = stack.pop()
        if (k, n) in closure:
            continue
        closure.add((k, n))
        src = src_path(k, n)
        if not os.path.exists(src):
            continue
        for line in open(src, errors="ignore"):
            m = re.match(r"import Definitions\.Def_(\S+)", line)
            if m:
                d = ("def", m.group(1))
            else:
                # capture WITHOUT the `Thm_` prefix — parse_target strips it too,
                # so (kind, name) tuples stay comparable (src_path re-adds it).
                m = re.match(r"import Theorems\.Thm_(\S+)", line)
                if not m:
                    continue
                d = ("thm", m.group(1))
            if os.path.exists(src_path(*d)) and d not in closure:
                stack.append(d)

    # topo sort over the closure
    order, seen = [], set()

    def deps(k, n):
        src = src_path(k, n)
        out = []
        if not os.path.exists(src):
            return out
        for line in open(src, errors="ignore"):
            m = re.match(r"import Definitions\.Def_(\S+)", line)
            if m:
                d = ("def", m.group(1))
            else:
                m = re.match(r"import Theorems\.Thm_(\S+)", line)
                if not m:
                    continue
                d = ("thm", m.group(1))
            if d in closure:
                out.append(d)
        return out

    def visit(k, n):
        if (k, n) in seen:
            return
        seen.add((k, n))
        for dk, dn in deps(k, n):
            visit(dk, dn)
        order.append((k, n))

    for k, n in sorted(closure):
        visit(k, n)

    todo = [(k, n) for k, n in order if not os.path.exists(olean_path(k, n))]
    print(f"closure {len(closure)} module(s), {len(todo)} missing oleans, JOBS={a.jobs}",
          flush=True)
    if not todo:
        print("nothing to build")
        return 0

    ok, failed = 0, []
    t0 = time.time()

    def build(kn):
        k, n = kn
        src = src_path(k, n)
        olean = olean_path(k, n)
        r = subprocess.run([lean_bin, "-o", olean, src], cwd=MIRROR, env=env,
                           capture_output=True, text=True)
        if r.returncode == 0:
            return (k, n, True, "")
        msg = (r.stdout + r.stderr).strip()
        first = next((l for l in msg.split("\n") if "error" in l), msg[:200])
        return (k, n, False, first.strip()[:200])

    with ThreadPoolExecutor(max_workers=a.jobs) as ex:
        futs = {ex.submit(build, kn): kn for kn in todo}
        for i, fut in enumerate(as_completed(list(futs)), 1):
            k, n, good, err = fut.result()
            if good:
                ok += 1
            else:
                failed.append((k, n, err))
                print(f"  FAIL {k}:{n}\n        {err}", flush=True)
            if i % 10 == 0 or i == len(todo):
                print(f"  [{i}/{len(todo)}] ok={ok} fail={len(failed)} "
                      f"{time.time()-t0:.0f}s", flush=True)

    print(f"\n=== SUMMARY === compiled {ok}, failed {len(failed)} in {time.time()-t0:.0f}s",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
