"""Make the mirror self-contained for a set of sols.

Why this exists: 2579 of 6967 mirror Theorems/*.lean ship as source only
(no .olean).  Lean's import mechanism needs the olean, so every sol whose
import closure touches one of them dies at the local gate with
`object file '...x.olean' does not exist` -- a mirror artifact, not a proof
error.  Running any of the standard gate tools while the drain stages new
bundles corrupts the run further (cache rewrite mid-gate), so the gate should
run against a snapshot taken after this script finishes.

Two gaps are filled per module, deps-first to a fixpoint:
  1. missing source -- Thm_* from the local Theorems/ stub (the text the
     platform compiled), Def_* from the published-bundle text cache;
  2. missing .olean -- `lean -DautoImplicit=false -o` from the mirror root,
     the way build_published_mirror.py and debug/_compile_thms.sh do it.

Usage: python3 debug/build_closure_oleans.py /tmp/needed_oleans.txt
"""
import os
import re
import subprocess
import sys
import time

MIRROR = os.environ.get("DEF_MIRROR", "/tmp/published_mirror")
WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
PUB_CACHE = f"{WS}/state/published_bundles"
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
IMP = re.compile(r"^import\s+(\S+)", re.M)


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd],
                          cwd=PROJ, capture_output=True, text=True).stdout.strip()


def stage_source(mod):
    """Place <src>/<name>.lean in the mirror if absent. True iff present."""
    src, name = mod.split(".", 1)
    path = f"{MIRROR}/{src}/{name}.lean"
    if os.path.exists(path):
        return True
    if src == "Theorems":
        local = f"{WS}/Theorems/{name}.lean"
    else:
        local = f"{PUB_CACHE}/{name}.lean"
    if not os.path.exists(local):
        return False
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(local, encoding="utf-8") as f:
        text = f.read()
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)
    return True


def compile_one(mod, lean, env_base):
    src, name = mod.split(".", 1)
    r = subprocess.run(
        [lean, "-DautoImplicit=false", "-o", f"{src}/{name}.olean", f"{src}/{name}.lean"],
        cwd=MIRROR, env=dict(env_base, LEAN_PATH=f"{MIRROR}:{env_base['_LEAN_PATH']}"),
        capture_output=True, text=True, timeout=900)
    return r.returncode == 0, (r.stdout + r.stderr)


def has_olean(mod):
    src, name = mod.split(".", 1)
    return os.path.exists(f"{MIRROR}/{src}/{name}.olean")


def main():
    mods = [l.strip() for l in open(sys.argv[1]) if l.strip()]
    env_base = dict(os.environ, PATH=f"{PATH_BIN}:{os.environ['PATH']}")
    env_base["_LEAN_PATH"] = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    pending = set(mods)
    failed = {}
    round_no = 0
    while pending and round_no < 12:
        round_no += 1
        ready, not_yet = [], []
        for mod in sorted(pending):
            src = mod.split(".", 1)[0]
            if not stage_source(mod):
                failed[mod] = "no source anywhere"
                continue
            txt = open(f"{MIRROR}/{mod.replace('.', '/')}.lean",
                       encoding="utf-8", errors="ignore").read()
            deps = [d for d in IMP.findall(txt)
                    if d.split(".", 1)[0] in ("Definitions", "Theorems")]
            if all(has_olean(d) for d in deps):
                ready.append(mod)
            else:
                not_yet.append(mod)
        pending = set(not_yet)
        print(f"round {round_no}: compiling {len(ready)}, waiting {len(not_yet)}",
              flush=True)
        for mod in ready:
            t0 = time.time()
            try:
                ok, out = compile_one(mod, lean, env_base)
            except subprocess.TimeoutExpired:
                ok, out = False, "timeout 900s"
            if ok:
                print(f"  OK    {mod}  ({time.time()-t0:.0f}s)", flush=True)
            else:
                err = next((l for l in out.splitlines() if "error" in l), out[:200])
                failed[mod] = err.strip()[:180]
                print(f"  FAIL  {mod}\n        {failed[mod]}", flush=True)
    # modules that never became ready because a dep never produced an olean
    for mod in pending:
        failed[mod] = "dep never produced an olean"
    print(f"\ndone: {sum(1 for m in mods if has_olean(m))}/{len(mods)} have oleans")
    if failed:
        print(f"failed {len(failed)}:")
        for m, e in sorted(failed.items()):
            print(f"  {m}\n    {e}")


if __name__ == "__main__":
    main()