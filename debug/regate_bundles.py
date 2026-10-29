#!/usr/bin/env python3
"""Re-check a LIST of def bundles against an already-built candidate mirror.

`build_candidate_mirror.py` recompiles the whole staged universe every run
(687 def bundles + their theorem closure, ~4.5 h serial), which is right for a
first pass and wrong for iterating on a handful of repaired bundles: their
dependencies are already `OK` in the mirror, so only the bundles themselves (plus
any theorem stub they newly import and that has no `.olean` yet) need compiling.

Same compiler, same flags (`-DautoImplicit=false`, same `LEAN_PATH` =
`{MIRROR}:{base}`), so the verdict is comparable to the full pass -- this changes
ONLY what gets recompiled, never what "OK" means.  Updates `state/def_gate.json`
for the requested targets only, keeping every other entry's verdict (the merge
rule `build_candidate_mirror` documents).

Usage:
  python3 debug/regate_bundles.py ChapterFoo ChapterBar
  python3 debug/regate_bundles.py --targets-file /tmp/fixed.txt [--jobs 4]
  python3 debug/regate_bundles.py --targets-file /tmp/fixed.txt --report /tmp/regate.tsv
"""
import argparse
import concurrent.futures
import hashlib
import json
import os
import re
import subprocess
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"


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
    ap.add_argument("chapters", nargs="*")
    ap.add_argument("--targets-file", default=None)
    ap.add_argument("--jobs", type=int, default=1)
    ap.add_argument("--report", default=None)
    a = ap.parse_args()

    targets = list(a.chapters)
    if a.targets_file:
        targets += [l.strip() for l in open(a.targets_file) if l.strip()]
    targets = [t for t in dict.fromkeys(targets) if t]
    if not targets:
        print("no targets"); return 2
    if not os.path.isdir(MIRROR):
        print(f"no candidate mirror at {MIRROR} -- run "
              f"debug/build_candidate_mirror.py first"); return 2

    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])

    def compile_one(kind, m):
        src = "Definitions" if kind == "D" else "Theorems"
        full = f"{MIRROR}/{src}/{m}.lean"
        if not os.path.exists(full):
            return kind, m, "NOSRC"
        try:
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o", f"{src}/{m}.olean",
                 f"{src}/{m}.lean"],
                cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                capture_output=True, text=True,
                # 1800 s is the build_candidate_mirror default and it TIMED OUT
                # on Def_ChapterQgOneParticleCcEsa (2026-10-27, gate=TIMEOUT,
                # 181 thm stubs deferred behind it).  Long-horizon bundles are
                # regated with REGATE_TIMEOUT=… (seconds) instead of waiting for
                # a full candidate-mirror pass.
                timeout=int(os.environ.get("REGATE_TIMEOUT", "1800")))
        except subprocess.TimeoutExpired:
            return kind, m, "TIMEOUT"
        out = r.stdout + r.stderr
        if r.returncode == 0:
            return kind, m, "OK"
        err = next((l for l in out.splitlines() if "error" in l), "")
        logdir = (a.report + ".logs") if a.report else "/tmp/regate_logs"
        os.makedirs(logdir, exist_ok=True)
        open(f"{logdir}/{kind}_{m}.log", "w").write(out)
        return kind, m, "FAIL " + err.strip().replace("\t", " ")[:300]

    # Stage the repaired bundles (and their newly-needed theorem stubs) into the
    # mirror: the mirror's copies are the ones compiled, so an unrepaired copy
    # would be re-verified instead of the edit.
    work_d, work_t = [], []
    for t in targets:
        src = f"{WS}/Definitions/Def_{t}.lean"
        if not os.path.exists(src):
            continue
        open(f"{MIRROR}/Definitions/Def_{t}.lean", "w").write(
            open(src).read())
        work_d.append(f"Def_{t}")
        for m in imports_of(src, "Theorems"):
            dst = f"{MIRROR}/Theorems/{m}.lean"
            s = f"{WS}/Theorems/{m}.lean"
            if os.path.exists(s):
                open(dst, "w").write(open(s).read())
            if not os.path.exists(f"{MIRROR}/Theorems/{m}.olean"):
                work_t.append(m)

    jobs, res = a.jobs, {}
    todo = [("T", m) for m in sorted(set(work_t))] + [("D", m) for m in work_d]
    # Two WAVES, not one pool.  `ThreadPoolExecutor.map` pulls from a shared
    # iterator, so with --jobs>1 a bundle could start before the theorem stub it
    # imports had produced its .olean -- `object file ... does not exist` on a
    # module that compiles fine seconds later.  Measured on
    # Def_ChapterAttentionCollision (FAIL) vs Def_ChapterAttentionOutputVariance
    # (OK) in the same run, same flags.  A def->thm edge must be honoured, which
    # is exactly the ordering build_candidate_mirror's levels provide.
    def run(wave):
        if not wave:
            return
        if jobs > 1:
            with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as ex:
                for kind, m, r in ex.map(lambda x: compile_one(*x), wave):
                    res[(kind, m)] = r
        else:
            for x in wave:
                kind, m, r = compile_one(*x)
                res[(kind, m)] = r

    run([("T", m) for m in sorted(set(work_t))])
    run([("D", m) for m in work_d])

    print(f"theorem stubs compiled: "
          f"{sum(1 for (k, _), v in res.items() if k == 'T' and v == 'OK')}"
          f"/{len(set(work_t))}")
    gate_path = os.path.join(WS, "state", "def_gate.json")
    try:
        gate = json.load(open(gate_path))
        if not isinstance(gate, dict):
            gate = {}
    except (OSError, ValueError):
        gate = {}
    rows, n_ok = [], 0
    for t in targets:
        status = res.get(("D", f"Def_{t}"), "NOSRC")
        # A bundle whose theorem stub failed is BLOCKED, not FAILed -- the
        # same distinction build_candidate_mirror draws.
        if status.startswith("FAIL"):
            bad = [m for m in imports_of(f"{MIRROR}/Definitions/Def_{t}.lean",
                                         "Theorems")
                   if res.get(("T", m), "OK") != "OK"]
            if bad:
                status = f"BLOCKED by Thm_{bad[0]}"
        p = f"{WS}/Definitions/Def_{t}.lean"
        try:
            stamp = hashlib.sha1(open(p, "rb").read()).hexdigest()[:16]
        except OSError:
            stamp = None
        gate[t] = {"status": status, "stamp": stamp}
        n_ok += status == "OK"
        rows.append((t, status))
    gate["_meta"] = {"generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
                     "regate_targets": len(targets)}
    json.dump(gate, open(gate_path, "w"), indent=1)
    if a.report:
        with open(a.report, "w") as fh:
            for t, s in rows:
                fh.write(f"{s}\t{t}\n")
    w = max(len(t) for t, _ in rows)
    for t, s in rows:
        print(f"{t:<{w}}  {s}")
    print(f"\n{len(targets)} targets re-gated, {n_ok} OK; "
          f"def_gate.json updated for these only")
    return 0


if __name__ == "__main__":
    sys.exit(main())
