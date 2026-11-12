#!/usr/bin/env python3
"""Parallel deps-first builder for the published mirror's oleans.

WHY
---
`build_published_mirror.py` compiles ~7228 modules one at a time (~5 s each ->
~10 h on this box). The work is a DAG, the machine has 12 cores, and most
bundles only depend on Mathlib plus two or three siblings, so almost every wave
is wide. This builds the same modules with the same `lean -o <olean> <src>`
invocation, cwd=MIRROR, LEAN_PATH=MIRROR:base as the serial builder -- the
oleans are interchangeable and the serial builder skips them via `--reuse`.

Waves are enforced (a module is dispatched only once every mirror dependency has
an olean), unlike `parallel_mirror_catchup.py`, which submits the whole topo
order at once and races modules against their own dependencies.

JOBS defaults to 3: a Mathlib-importing file costs ~1.5 GB, and this box has
15 GB -- admitting more has already taken the machine down once.

USAGE
-----
    PROVE2ME_WS=<ws> TIMEPIECE_PROJ=<proj> python3 debug/parallel_mirror_build.py
    ... --only BookProof_FockStatistics_bosonicFock_esa   # just that closure
    JOBS=4 ...
"""
import importlib.util
import json
import os
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, wait

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
PROJ = os.environ.get("TIMEPIECE_PROJ") or os.environ.get("PROVE2ME_PROJ") or ""
# Repo-local (AGENTS.md rule 4): the mirror is the oracle for every statement
# check and must outlive a reboot.
MIRROR = os.environ.get("DEF_MIRROR") or os.path.join(WS, "state", "published_mirror")
JOBS = int(os.environ.get("JOBS", "3"))

_dm = os.path.join(HERE, "def_mirror.py")
_spec = importlib.util.spec_from_file_location("def_mirror", _dm)
dm = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(dm)


def lake_env_sh(script):
    return subprocess.run(["lake", "env", "bash", "-c", script], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def imports_of(path):
    out = []
    for line in open(path, errors="ignore"):
        m = re.match(r"import Definitions\.Def_(\S+)", line)
        if m:
            out.append(("def", m.group(1)))
            continue
        m = re.match(r"import Theorems\.(Thm_\S+)", line)
        if m:
            out.append(("thm", m.group(1)))
    return out


def path_of(kind, name):
    folder = "Definitions" if kind == "def" else "Theorems"
    return os.path.join(MIRROR, folder,
                        f"{'Def_' if kind == 'def' else ''}{name}.lean")


def closure(starts, nodes):
    """Every mirror module reachable by imports from `starts` (plus the starts)."""
    out, seen = [], set()

    def visit(kind, name):
        key = (kind, name)
        if key in seen:
            return
        seen.add(key)
        if key not in nodes:
            return
        for d in imports_of(path_of(kind, name)):
            visit(*d)
        out.append(key)

    for s in starts:
        visit(*s)
    return out


def main():
    if not PROJ:
        print("set TIMEPIECE_PROJ")
        return 2
    base = lake_env_sh('printf %s "$LEAN_PATH"')
    lean = lake_env_sh("command -v lean")
    if not base or not lean:
        print("could not read the lean env from `lake env`")
        return 2
    env = dict(os.environ, LEAN_PATH=MIRROR + ":" + base)

    nodes = set()
    for kind, folder, prefix in (("def", "Definitions", "Def_"),
                                 ("thm", "Theorems", "")):
        d = os.path.join(MIRROR, folder)
        if not os.path.isdir(d):
            continue
        for f in os.listdir(d):
            if f.endswith(".lean") and f.startswith(prefix):
                nodes.add((kind, f[len(prefix):-len(".lean")]))

    if "--only" in sys.argv:
        names = sys.argv[sys.argv.index("--only") + 1:]
        starts = [(k, n) for k, n in nodes for s in names
                  if n == s or n == f"Thm_{s}" or n.endswith(s)]
        order = closure(starts, nodes)
    elif "--sol" in sys.argv:
        # start from a solution file: its own imports are exactly the statement
        # modules and def bundles it must see compiled.
        names = sys.argv[sys.argv.index("--sol") + 1:]
        starts = []
        for s in names:
            src = os.path.join(WS, "Solutions", f"Sol_{s}.lean")
            if not os.path.exists(src):
                print(f"  MISSING Solutions/Sol_{s}.lean")
                continue
            starts += imports_of(src)
        order = closure(starts, nodes)
    else:
        order = closure(nodes, nodes)

    todo = [kn for kn in order
            if not os.path.exists(path_of(*kn)[:-5] + ".olean")]
    print(f"{len(order)} module(s) in scope, {len(todo)} missing oleans, JOBS={JOBS}",
          flush=True)

    ok, failed, skipped = 0, [], []
    t0 = time.time()
    # modules that already have an olean count as built: a dependency check must
    # not stall on them (first version left 7 modules "not reached" in 0 s).
    done = {kn for kn in order if os.path.exists(path_of(*kn)[:-5] + ".olean")}
    queued = set(todo)
    dispatched = set()

    def ready(kn):
        if kn in done or kn in dispatched:
            return False
        return all((d in done) or d not in nodes
                   for d in imports_of(path_of(*kn)))

    with ThreadPoolExecutor(max_workers=JOBS) as ex:
        inflight = {}
        while True:
            for kn in list(queued):
                if len(inflight) >= JOBS:
                    break
                if ready(kn):
                    queued.discard(kn)
                    dispatched.add(kn)
                    src = path_of(*kn)
                    inflight[ex.submit(subprocess.run,
                                       [lean, "-o", src[:-5] + ".olean", src],
                                       cwd=MIRROR, env=env,
                                       capture_output=True, text=True)] = kn
            if not inflight:
                break
            finished, _ = wait(list(inflight), return_when="FIRST_COMPLETED")
            for fut in finished:
                kind, name = inflight.pop(fut)
                r = fut.result()
                if r.returncode == 0:
                    ok += 1
                    done.add((kind, name))
                else:
                    msg = (r.stdout + r.stderr).strip()
                    first = next((l for l in msg.split("\n") if "error" in l), msg[:200])
                    failed.append((kind, name, first.strip()[:180]))
                if (ok + len(failed)) % 25 == 0:
                    print(f"  [{ok + len(failed)}] ok={ok} fail={len(failed)} "
                          f"{time.time() - t0:.0f}s", flush=True)

        skipped = [kn for kn in queued]
        # queued items whose deps failed can never become ready; the ones left
        # with no failed dependency are simply what a smaller JOBS budget did
        # not reach.
        failed_keys = {(k, n) for k, n, _ in failed}
        blocked = [kn for kn in skipped
                   if any(d in failed_keys for d in imports_of(path_of(*kn)))]

    print(f"\n=== SUMMARY === compiled {ok}, failed {len(failed)}, "
          f"not reached {len(skipped) - len(blocked)}, blocked by a failure "
          f"{len(blocked)} in {time.time() - t0:.0f}s", flush=True)
    for kind, name, err in failed[:40]:
        print(f"  {kind}:{name}: {err}")
    if len(failed) > 40:
        print(f"  ... and {len(failed) - 40} more")
    json.dump([{"kind": k, "leaf": n, "error": e} for k, n, e in failed],
              open(os.path.join(WS, "state", "mirror_build_failures.json"), "w"),
              indent=1)
    return 0


if __name__ == "__main__":
    sys.exit(main())
