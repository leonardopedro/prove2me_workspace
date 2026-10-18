"""Compile-verified `state/thm_gate.json` entries for a handful of slugs.

`debug/build_candidate_mirror.py` recompiles the WHOLE staged universe (~964
modules, hours at 10 jobs) before it can freshen gate verdicts for a few new
stubs -- new `_inc` replacements get WAIT ("stub not covered by the last thm
build") long after they were proven to compile.  This script runs the SAME
oracle on just the requested slugs and merges verdicts in, without touching
any other entry (merge, don't replace, exactly like build_candidate_mirror's
own gate write).

Faithfulness contract (must stay identical to build_candidate_mirror.compile_one
and its gate write, so upload_pipeline.thm_gate_fresh cannot tell them apart):
  * stage Theorems/Thm_<name>.lean from the workspace into the candidate
    mirror (the platform compiles the workspace text),
  * compile with the same toolchain, `lake env`-resolved `lean`, the same
    flags (-DautoImplicit=false), cwd=MIRROR and LEAN_PATH=MIRROR:base,
  * stamp = sha1(workspace file).hexdigest()[:16] (== upload_pipeline.file_stamp),
  * status = "OK" on returncode 0, else "FAIL <first error line>" -- a FAIL
    defers in the pipeline, an OK gates it through.

Only an actual compile can write "OK": no verdict is invented here, and the
state file remains generated (this script is the generator; nothing hand-edits
state/).

Usage:
  python3 debug/gate_thm_ok.py BrstReducedTransfer_infDist_exactStates_eq_inc ...
  # slug forms accepted: <bare>, BookProof_<name>, Thm_BookProof_<name>,
  # or a file of one slug per line:  --from-file /tmp/only_inc.txt
"""
import argparse
import concurrent.futures
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
GATE = f"{WS}/state/thm_gate.json"
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def norm_mod(s):
    """Any accepted slug spelling -> (gate key, mirror module name)."""
    s = s.strip()
    if s.startswith("Thm_"):
        s = s[4:]
    if not s.startswith("BookProof_"):
        s = "BookProof_" + s
    return s, "Thm_" + s


def stamp_of(path):
    try:
        with open(path, "rb") as fh:
            return hashlib.sha1(fh.read()).hexdigest()[:16]
    except OSError:
        return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file", default=None,
                    help="file of one slug per line (e.g. /tmp/only_inc.txt)")
    ap.add_argument("--jobs", type=int, default=8)
    a = ap.parse_args()

    slugs = list(a.slugs)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    if not slugs:
        ap.error("no slugs given")

    mods = []
    for s in slugs:
        key, mod = norm_mod(s)
        if (key, mod) not in mods:
            mods.append((key, mod))

    os.makedirs(f"{MIRROR}/Theorems", exist_ok=True)
    missing = []
    todo = []
    for key, mod in mods:
        src = f"{WS}/Theorems/{mod}.lean"
        if not os.path.exists(src):
            missing.append(mod)
            continue
        shutil.copyfile(src, f"{MIRROR}/Theorems/{mod}.lean")
        todo.append((key, mod, src))
    for m in missing:
        print(f"NOSRC {m}")

    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])

    def compile_one(item):
        key, mod, src = item
        try:
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o", f"Theorems/{mod}.olean",
                 f"Theorems/{mod}.lean"], cwd=MIRROR,
                env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                capture_output=True, text=True, timeout=1800)
        except subprocess.TimeoutExpired:
            return key, mod, "FAIL TIMEOUT", stamp_of(src)
        out = r.stdout + r.stderr
        if r.returncode == 0:
            return key, mod, "OK", stamp_of(src)
        err = next((l for l in out.splitlines() if "error" in l), "")
        log = f"/tmp/gate_thm_{mod}.log"
        open(log, "w").write(out)
        return key, mod, "FAIL " + err.strip()[:300], stamp_of(src)

    results = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=max(1, a.jobs)) as ex:
        results = list(ex.map(compile_one, todo))

    try:
        gate = json.load(open(GATE))
        if not isinstance(gate, dict):
            gate = {}
    except (OSError, ValueError):
        gate = {}
    for key, mod, status, stamp in results:
        gate[key] = {"status": status, "stamp": stamp}
        print(f"{status.split(' ', 1)[0]:4} {key}"
              + ("" if status == "OK" else " :: " + status[5:140]))
    meta = gate.get("_meta")
    if not isinstance(meta, dict):
        meta = {}
    meta.setdefault("scoped_compiles", []).append(
        time.strftime("%Y-%m-%dT%H:%M:%S") + " x" + str(len(results)))
    gate["_meta"] = meta
    json.dump(gate, open(GATE, "w"), indent=1)

    bad = [k for k, _, s, _ in results if s != "OK"]
    print(f"wrote {len(results)} entr{'y' if len(results) == 1 else 'ies'} "
          f"to {GATE} ({len(results) - len(bad)} OK, {len(bad)} not OK)")
    return 1 if (bad or missing) else 0


if __name__ == "__main__":
    sys.exit(main())