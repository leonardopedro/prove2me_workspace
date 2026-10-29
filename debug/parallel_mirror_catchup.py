#!/usr/bin/env python3
"""Parallel deps-first catch-up for missing mirror oleans.

The serial `build_published_mirror.py` compiles ~7520 modules one at a time
(~5 s each -> ~10 h). Local sol checks only need the olean for each sol's OWN
import closure, not the whole graph. This builds just the missing ones, in
dependency order, across N workers, using the exact same `lean -o <olean> <src>`
invocation (cwd=MIRROR, LEAN_PATH=MIRROR:base) that the serial builder uses, so
the oleans are interchangeable and the serial builder will skip them via
`--reuse` once present.

It is safe to run alongside the serial builder: both skip any olean that
already exists, and both write the same bytes for a given source. Worst case a
module is compiled twice (wasted CPU, no corruption).
"""
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
JOBS = int(os.environ.get("JOBS", "8"))

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


def src_path(kind, name):
    folder = "Definitions" if kind == "def" else "Theorems"
    prefix = "Def_" if kind == "def" else ""
    return os.path.join(MIRROR, folder, f"{prefix}{name}.lean")


def main():
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

    # Every module present in the mirror (def + theorem), whether or not it has
    # an olean yet.
    nodes = []
    for kind, folder, prefix in (("def", "Definitions", "Def_"),
                                 ("thm", "Theorems", "")):
        d = os.path.join(MIRROR, folder)
        if not os.path.isdir(d):
            continue
        for f in os.listdir(d):
            if f.endswith(".lean"):
                nodes.append((kind, f[len(prefix):-5] if f.startswith(prefix) else f[:-5]))
    node_set = {f"{k}:{n}" for k, n in nodes}

    def deps(kind, name):
        p = src_path(kind, name)
        if not os.path.exists(p):
            return []
        return [d for d in imports_of(p) if f"{d[0]}:{d[1]}" in node_set]

    # topo sort
    order, seen = [], set()

    def visit(kind, name):
        key = f"{kind}:{name}"
        if key in seen:
            return
        seen.add(key)
        for dk, dn in deps(kind, name):
            visit(dk, dn)
        order.append((kind, name))

    for kind, name in nodes:
        visit(kind, name)

    todo = [(k, n) for k, n in order if not os.path.exists(src_path(k, n)[:-5] + ".olean")]
    print(f"{len(order)} module(s) total, {len(todo)} missing oleans, JOBS={JOBS}", flush=True)

    ok, failed = 0, []
    t0 = time.time()

    def build(kind_name):
        kind, name = kind_name
        src = src_path(kind, name)
        olean = src[:-5] + ".olean"
        r = subprocess.run([lean_bin, "-o", olean, src], cwd=MIRROR, env=env,
                           capture_output=True, text=True)
        if r.returncode == 0:
            return (kind, name, True, "")
        msg = (r.stdout + r.stderr).strip()
        first = next((l for l in msg.split("\n") if "error" in l), msg[:200])
        return (kind, name, False, first.strip()[:180])

    with ThreadPoolExecutor(max_workers=JOBS) as ex:
        futs = [ex.submit(build, kn) for kn in todo]
        for i, fut in enumerate(as_completed(futs), 1):
            kind, name, good, err = fut.result()
            if good:
                ok += 1
            else:
                failed.append((kind, name, err))
            if i % 25 == 0 or i == len(todo):
                print(f"  [{i}/{len(todo)}] ok={ok} fail={len(failed)} "
                      f"{time.time()-t0:.0f}s", flush=True)

    print(f"\n=== CATCHUP SUMMARY === compiled {ok}, failed {len(failed)} "
          f"in {time.time()-t0:.0f}s", flush=True)
    for kind, name, err in failed[:40]:
        print(f"  {kind}:{name}: {err}")
    if len(failed) > 40:
        print(f"  ... and {len(failed)-40} more")
    import json
    json.dump([{"kind": k, "leaf": n, "error": e} for k, n, e in failed],
              open(os.path.join(WS, "state", "mirror_catchup_failures.json"), "w"), indent=1)
    return 0


if __name__ == "__main__":
    sys.exit(main())
