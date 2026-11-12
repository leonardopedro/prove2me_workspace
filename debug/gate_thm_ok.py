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
    mirror (the platform compiles the workspace text) -- `state/mirror` by
    default, `/tmp` is tmpfs and loses the oleans on reboot (AGENTS.md rule 4),
    so the environment override is the only way to move it,
  * compile with the same toolchain, `lake env`-resolved `lean`, the same
    flags (-DautoImplicit=false), cwd=MIRROR and LEAN_PATH=MIRROR:base,
  * stamp = sha1(workspace file).hexdigest()[:16] (== upload_pipeline.file_stamp),
  * status = "OK" on returncode 0, else "FAIL <first error line>" -- a FAIL
    defers in the pipeline, an OK gates it through.

Only an actual compile can write "OK": no verdict is invented here, and the
state file remains generated (this script is the generator; nothing hand-edits
state/).

A FAIL that reads `unknown namespace` / `unknown identifier` for a name the def
bundle is supposed to declare is a MIRROR artifact, not a verdict: the mirror's
definition olean is stale.  `python3 debug/sync_stale_mirror.py --check
--defs-only` names the stale modules (exit 1) and the same command without
`--check` refreshes them; re-run this script afterwards.

Usage:
  python3 debug/gate_thm_ok.py BrstReducedTransfer_infDist_exactStates_eq_inc ...
  # slug forms accepted: <bare>, BookProof_<name>, Thm_BookProof_<name>,
  # or a file of one slug per line:  --from-file state/scratch/only_inc.txt
  # report the mirror in use and the staging plan without compiling anything:
  python3 debug/gate_thm_ok.py --check --from-file state/scratch/only_inc.txt
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
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
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


def check(mods):
    """Report the mirror a run would use and what it would stage.  Read-only.

    Answers the two questions a compile answer is useless without: *which*
    mirror (the default moved from `/tmp/def_candidate` to `state/mirror`, so a
    stale shell export silently selects the old tree) and *what* the run would
    put in it -- the gate is keyed by upload_pipeline.file_stamp, so a verdict
    for a different revision of the stub is not a verdict at all.

    Exit 0 when every requested stub has a source to stage, 1 when any does not
    (the same condition that makes a real run fail), 2 when the mirror is
    missing (nothing could be compiled into it).
    """
    try:
        gate = json.load(open(GATE))
        if not isinstance(gate, dict):
            gate = {}
    except (OSError, ValueError):
        gate = {}

    print(f"mirror : {MIRROR}")
    if not os.path.isdir(os.path.join(MIRROR, "Theorems")):
        print(f"         MISSING -- {MIRROR}/Theorems does not exist; a run would "
              f"create it and compile against an empty LEAN_PATH half")
        return 2
    print(f"         {len(os.listdir(os.path.join(MIRROR, 'Theorems')))} file(s) "
          f"in Theorems/")
    print(f"gate   : {GATE}")
    print()
    print(f"{'slug':<62} {'src':<7} {'staged':<8} {'olean':<8} verdict")
    missing = 0
    for key, mod in mods:
        src = os.path.join(WS, "Theorems", f"{mod}.lean")
        dst = os.path.join(MIRROR, "Theorems", f"{mod}.lean")
        olean = os.path.join(MIRROR, "Theorems", f"{mod}.olean")
        stamp = stamp_of(src)
        if stamp is None:
            missing += 1
            print(f"{key:<62} {'NOSRC':<7} {'-':<8} {'-':<8} nothing to "
                  f"stage")
            continue
        if not os.path.exists(dst):
            staged = "copy"
        elif stamp_of(dst) != stamp:
            staged = "copy"
        else:
            staged = "same"
        if not os.path.exists(olean):
            built = "none"
        else:
            built = "keep"
        ent = gate.get(key) if isinstance(gate.get(key), dict) else None
        if ent and ent.get("stamp") == stamp:
            st = str(ent.get("status") or "?")
            # Same reading as upload_pipeline.thm_gate_fresh: a FAIL defers, an
            # OK gates through, and UNKNOWN is no evidence either way.
            verdict = {"OK": "fresh OK -- submits",
                       "UNKNOWN": "fresh UNKNOWN -- submits (no evidence)"}.get(
                st, "fresh " + st.split(" ", 1)[0] + " -- defers")
        elif ent:
            verdict = ("STALE stamp " + str(ent.get("stamp"))
                       + " != " + stamp + " -- defers until rebuilt")
        else:
            verdict = "no gate entry -- defers"
        print(f"{key:<62} {'ok':<7} {staged:<8} {built:<8} {verdict}")
    print()
    print(f"would stage {sum(1 for _, m in mods if os.path.exists(os.path.join(WS, 'Theorems', f'{m}.lean')))}"
          f"/{len(mods)} stub(s); {missing} without a workspace source."
          f" No compile, no gate write.")
    return 1 if missing else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file", default=None,
                    help="file of one slug per line "
                         "(e.g. state/scratch/only_inc.txt)")
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--check", action="store_true",
                    help="report the mirror in use and what would be staged, "
                         "then exit without compiling or writing the gate")
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

    if a.check:
        return check(mods)

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
        # The failure text is the diagnosis for a FAIL -- it outlives the run
        # only inside the repo (state/ is regenerable, /tmp is not).
        log = f"{WS}/state/logs/gate_thm_{mod}.log"
        os.makedirs(os.path.dirname(log), exist_ok=True)
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