"""Build a candidate Definitions mirror in TOPOLOGICAL order.

The candidate def bundles import each other, so they cannot be checked one at a
time: compiling bundle B needs B's imports to already have oleans. This walks the
import graph over {the 381 published bundles} u {the candidates}, orders it, and
compiles in that order so every bundle sees its dependencies.

Three orderings matter and are handled separately:
  def -> def        topological over Definitions
  thm -> def        a theorem stub may import a Definitions bundle
  def -> thm        a def bundle may import a Theorems stub (PIPELINE_PLAN 1s)

Usage:
  python3 debug/build_candidate_mirror.py --targets targets.txt [--jobs N]
"""
import argparse
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
PUB_DEFS = f"{WS}/state/published_bundles"
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


def topo(mods, deps_of):
    order, seen, stack = [], set(), set()

    def visit(m):
        if m in seen:
            return
        if m in stack:
            return  # cycle: order arbitrarily, the compiler will say so
        stack.add(m)
        for d in deps_of(m):
            if d in mods:
                visit(d)
        stack.discard(m)
        seen.add(m)
        order.append(m)

    for m in sorted(mods):
        visit(m)
    return order


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--targets", required=True)
    ap.add_argument("--report", default=None)
    a = ap.parse_args()

    targets = [l.strip() for l in open(a.targets) if l.strip()]
    os.makedirs(f"{MIRROR}/Definitions", exist_ok=True)
    os.makedirs(f"{MIRROR}/Theorems", exist_ok=True)

    # stage: published bundles + candidates
    for f in os.listdir(PUB_DEFS):
        if f.endswith(".lean"):
            open(f"{MIRROR}/Definitions/{f}", "w").write(open(f"{PUB_DEFS}/{f}").read())
    for t in targets:
        src = f"{WS}/Definitions/Def_{t}.lean"
        if os.path.exists(src):
            open(f"{MIRROR}/Definitions/Def_{t}.lean", "w").write(open(src).read())

    all_defs = {f[:-5] for f in os.listdir(f"{MIRROR}/Definitions") if f.endswith(".lean")}
    cand = {f"Def_{t}" for t in targets}
    ddeps = {m: [x for x in imports_of(f"{MIRROR}/Definitions/{m}.lean", "Definitions")
                 if x in all_defs] for m in all_defs}
    def_order = topo(all_defs, lambda m: ddeps[m])

    # theorem stubs the candidates need
    need_thm = set()
    for m in cand:
        need_thm.update(imports_of(f"{MIRROR}/Definitions/{m}.lean", "Theorems"))
    for t in sorted(need_thm):
        src = f"{WS}/Theorems/{t}.lean"
        if os.path.exists(src):
            open(f"{MIRROR}/Theorems/{t}.lean", "w").write(open(src).read())

    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])

    def compile_in(kind, mods):
        res = {}
        for m in mods:
            p = f"{kind}/{m}.lean"
            full = f"{MIRROR}/{p}"
            if not os.path.exists(full):
                res[m] = "NOSRC"
                continue
            r = subprocess.run([lean, "-o", f"{kind}/{m}.olean", p], cwd=MIRROR,
                               env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                               capture_output=True, text=True, timeout=1200)
            out = r.stdout + r.stderr
            if r.returncode == 0:
                res[m] = "OK"
            else:
                err = next((l for l in out.splitlines() if "error" in l), "")
                res[m] = "FAIL " + err.split("error", 1)[-1].strip()[:90]
        return res

    thm_mods = sorted({f[:-5] for f in os.listdir(f"{MIRROR}/Theorems")
                       if f.endswith(".lean")})
    thm_res = compile_in("Theorems", thm_mods)
    ok_thm = {m for m, v in thm_res.items() if v == "OK"}
    print(f"Theorems: {len(ok_thm)}/{len(thm_mods)} compiled")

    # defs, deps-first, skipping ones whose theorem imports did not build
    dres, order = {}, topo(sorted(all_defs), lambda m: ddeps[m])
    for m in order:
        p = f"{MIRROR}/Definitions/{m}.lean"
        if not os.path.exists(p):
            dres[m] = "NOSRC"
            continue
        missing = [t for t in imports_of(p, "Theorems") if t not in ok_thm]
        if missing:
            dres[m] = f"BLOCKED by {missing[0]}"
            continue
        r = subprocess.run([lean, "-o", f"Definitions/{m}.olean",
                            f"Definitions/{m}.lean"], cwd=MIRROR,
                           env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                           capture_output=True, text=True, timeout=1800)
        out = r.stdout + r.stderr
        dres[m] = "OK" if r.returncode == 0 else (
            "FAIL " + next((l for l in out.splitlines() if "error" in l),
                           "")[:100])

    ok = sorted(m[len("Def_"):] for m in cand if dres.get(m) == "OK")
    print(f"candidate defs OK: {len(ok)}/{len(targets)}")
    if a.report:
        with open(a.report, "w") as fh:
            for t in targets:
                fh.write(f"{dres.get('Def_' + t, 'NOSRC')}\t{t}\n")
    open("/tmp/cand_ok.txt", "w").write("\n".join(ok) + "\n")


if __name__ == "__main__":
    sys.exit(main())
