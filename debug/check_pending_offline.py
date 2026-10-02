#!/usr/bin/env python3
"""Decide pending pipeline items offline, against the published mirror.

WHY
---
Every submission costs one of five attempts, and a broken file burns one per
visit until it is parked as `failed`. The uploader's local gate compiles each
file in *this* checkout, which is not the world the platform compiles in: 87 of
150 published bundles have drifted from their local file, so a local pass is not
evidence. `build_published_mirror.py` now elaborates all 155 published modules
using the platform's own text; this script uses that mirror as the oracle, so
"will this waste an attempt?" is answerable without spending one.

WHAT IT CHECKS
--------------
`thm:<name>`   the platform compiles `preamble + formal_statement` in the
               published world. So does this: `import Mathlib`, the
               Definitions import and opens that `upload_pipeline.IMPORT_DEF` /
               `OPENS` supply, then the statement extracted from
               `Theorems/Thm_<name>.lean`.

`sol:<name>`   the platform compiles `Solutions/Sol_<name>.lean` in the
               published world *plus the problem's own statement module*.
               A solution imports `Theorems.Thm_*` that is not published (that
               is what "pending" means), and Lean will not build a module from
               source during an import -- so phase 1 builds those statement
               modules against the mirror, and phase 2 compiles the solutions.

CLASSIFICATION
--------------
  ok             compiles clean
  FAIL:<err>     a Lean error; submitting would burn an attempt
  SKIP:<reason>  cannot judge here (no local file, no mirror, timeout)

A SKIP is not a pass. Only `ok` is evidence.

USAGE
-----
    PROVE2ME_WS=<ws> TIMEPIECE_PROJ=<timepiece331> \
      python3 debug/check_pending_offline.py --kind thm --jobs 4
    ... --kind sol
    ... --only <substring>
"""
import concurrent.futures as cf
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
PROJ = os.environ.get("TIMEPIECE_PROJ") or f"{WS}/../timepiece331"
MIRROR = "/tmp/published_mirror"
OUT = f"{WS}/state/offline_pending_check.json"
SOL_DIR = f"{WS}/Solutions"
THM_DIR = f"{WS}/Theorems"

sys.path.insert(0, f"{WS}/pipeline")
import upload_pipeline as up  # noqa: E402

STATEMENT_IMPORT = re.compile(r"^\s*import Theorems\.(\S+)", re.M)


def lean_env():
    """The mirror first, then the published Lean/Mathlib search path.

    Order matters: a module in the mirror must win over the same module in this
    checkout, or the check would silently measure the drifted local copy again.
    """
    def sh(script):
        return subprocess.run(["lake", "env", "bash", "-c", script], cwd=PROJ,
                              capture_output=True, text=True).stdout.strip()
    base = sh('printf %s "$LEAN_PATH"')
    lean = sh("command -v lean")
    if not base or not lean:
        return None, None
    return lean, MIRROR + ":" + base


def first_error(out):
    for line in (out or "").split("\n"):
        if "error" in line:
            return line.strip()[:200]
    return (out or "").strip().split("\n")[0][:200] if out.strip() else "nonzero exit, no error line"


def compile_one(lean, env, src, workdir):
    """Compile `src`; return (ok, first_error)."""
    os.makedirs(workdir, exist_ok=True)
    r = subprocess.run([lean, src], cwd=workdir, env=env,
                       capture_output=True, text=True, timeout=900)
    out = r.stdout + r.stderr
    if r.returncode == 0:
        return True, ""
    return False, first_error(out)


def pending(kind):
    st = json.load(open(f"{WS}/state/pipeline.json"))
    items = st["items"]
    out = []
    for key, rec in items.items():
        if not key.startswith(f"{kind}:"):
            continue
        if rec.get("status") != "pending":
            continue
        out.append(key.split(":", 1)[1])
    return sorted(out)


def formal_of(name):
    """Split a statement module exactly as the wave path does before submitting.

    The legacy path sends a fixed preamble (`import Mathlib` + Definitions import
    + OPENS). The wave path does not: it sends everything before the declaration
    -- the file's own imports, opens, `variables`, `omit ... in` -- as the
    preamble, and the declaration alone as `formal_statement`. That is what the
    platform compiles, so it is what has to be checked. Using the legacy
    preamble for a BookProof chapter reports ~121/129 statements as broken when
    they merely needed their own chapter's imports.

    Returns (preamble, formal, error)."""
    path = f"{THM_DIR}/Thm_{name}.lean"
    if not os.path.exists(path):
        return None, None, "no local Theorems/Thm_%s.lean" % name
    txt = open(path, encoding="utf-8").read()
    # Split at the first top-level `theorem`. Do NOT try to reconstruct the Lean
    # declaration name from the pipeline key: the key underscores chapter and
    # identifier alike (BookProof_ChapterH6_krylov_rayleigh_transfer), so
    # `replace("_", ".")` mangles the identifier into
    # BookProof.ChapterH6.krylov.rayleigh.transfer and the match fails. When that
    # happened this function fell through to the legacy fixed preamble and
    # reported 126 of 129 pending statements as broken when they were not.
    # Split at the FIRST top-level `theorem`, whatever it is named. Matching the
    # pipeline's slug does not work: the key underscores chapter and identifier
    # alike, so `BookProof_HermiteProductCore_hermiteCx_zero` cannot be
    # reconstructed from `BookProof.HermiteProductCore.hermiteCx_zero`. Getting
    # this wrong reported 10 statements as "cannot locate a declaration" when
    # they were perfectly fine.
    # Allow leading whitespace: a stub whose declarations sit inside a `namespace`
    # indents them, so anchoring at column 0 missed them and reported 10
    # perfectly good statements as "cannot locate a declaration".
    m = re.search(r"(?m)^[ \t]*theorem\s+\S", txt)
    if not m:
        return None, None, "cannot locate a declaration in Thm_%s.lean" % name
    preamble = txt[:m.start()].rstrip()
    formal = txt[m.start():].strip()
    return preamble, formal, ""


def run_thm(lean, env, names, only, jobs):
    work = tempfile.mkdtemp(prefix="offline-thm-")
    out = {}

    def one(name):
        if only and only not in name:
            return None
        pre, formal, why = formal_of(name)
        if formal is None:
            return name, ("SKIP:" + why)
        path = os.path.join(work, f"Chk_{abs(hash(name)) % 10**8}.lean")
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(pre + "\n\n" + formal + "\n")
        ok, err = compile_one(lean, env, path, work)
        return name, ("ok" if ok else "FAIL:" + err)

    sel = [n for n in names if not only or only in n]
    with cf.ThreadPoolExecutor(max_workers=jobs) as ex:
        for res in ex.map(one, sel):
            if res:
                out[res[0]] = res[1]
    shutil.rmtree(work, ignore_errors=True)
    return out


def run_sol(lean, env, names, only, jobs):
    """Two phases: build the pending statement modules, then the solutions.

    Phase 1 output goes into a scratch `Theorems/` that is prepended to the
    search path, so `import Theorems.Thm_*` resolves for the solution without
    touching the mirror (which must keep reflecting only published modules)."""
    scratch = tempfile.mkdtemp(prefix="offline-sol-")
    thm_out = os.path.join(scratch, "Theorems")
    os.makedirs(thm_out, exist_ok=True)
    work = os.path.join(scratch, "work")
    os.makedirs(work, exist_ok=True)
    senv = dict(env)
    senv["LEAN_PATH"] = thm_out + ":" + senv["LEAN_PATH"]

    wanted = []
    for name in names:
        if only and only not in name:
            continue
        path = f"{SOL_DIR}/Sol_{name}.lean"
        if not os.path.exists(path):
            continue
        for mod in STATEMENT_IMPORT.findall(open(path, encoding="utf-8").read()):
            if mod not in wanted:
                wanted.append(mod)

    built = {}

    def build(mod):
        src = f"{THM_DIR}/{mod}.lean"
        if not os.path.exists(src):
            return mod, ("SKIP:no local Theorems/%s.lean" % mod)
        shutil.copy2(src, os.path.join(thm_out, f"{mod}.lean"))
        ok, err = compile_one(lean, senv, os.path.join(thm_out, f"{mod}.lean"), work)
        return mod, ("ok" if ok else "FAIL:" + err)

    with cf.ThreadPoolExecutor(max_workers=jobs) as ex:
        for mod, res in ex.map(build, wanted):
            built[mod] = res

    out = {}

    def one(name):
        if only and only not in name:
            return None
        path = f"{SOL_DIR}/Sol_{name}.lean"
        if not os.path.exists(path):
            return name, "SKIP:no local Solutions/Sol_%s.lean" % name
        shutil.copy2(path, os.path.join(work, f"Chk_{abs(hash(name)) % 10**8}.lean"))
        ok, err = compile_one(lean, senv, os.path.join(work, f"Chk_{abs(hash(name)) % 10**8}.lean"), work)
        return name, ("ok" if ok else "FAIL:" + err)

    sel = [n for n in names if not only or only in n]
    with cf.ThreadPoolExecutor(max_workers=jobs) as ex:
        for res in ex.map(one, sel):
            if res:
                out[res[0]] = res[1]
    shutil.rmtree(scratch, ignore_errors=True)
    return out, built


def summarise(res, label):
    ok = sum(1 for v in res.values() if v == "ok")
    fail = sum(1 for v in res.values() if v.startswith("FAIL:"))
    skip = sum(1 for v in res.values() if v.startswith("SKIP:"))
    print(f"\n=== {label}: {len(res)} item(s) ===")
    print(f"  ok   {ok}")
    print(f"  FAIL {fail}")
    print(f"  SKIP {skip}")
    return ok, fail, skip


def main():
    kinds = []
    for a in sys.argv[1:]:
        if a.startswith("--kind="):
            kinds.append(a.split("=", 1)[1])
    if "--kind" in sys.argv:
        kinds += sys.argv[sys.argv.index("--kind") + 1].split(",")
    if not kinds:
        kinds = ["thm", "sol"]
    only = None
    if "--only" in sys.argv:
        only = sys.argv[sys.argv.index("--only") + 1]
    jobs = 4
    if "--jobs" in sys.argv:
        jobs = int(sys.argv[sys.argv.index("--jobs") + 1])

    if not os.path.isdir(MIRROR):
        print(f"no published mirror at {MIRROR}; run debug/build_published_mirror.py first")
        return 2
    lean, env_path = lean_env()
    if not lean:
        print("could not read the Lean environment from `lake env`")
        return 2
    env = dict(os.environ)
    env["LEAN_PATH"] = env_path

    allres = {}
    for kind in kinds:
        names = pending(kind)
        print(f"{kind}: {len(names)} pending", flush=True)
        if kind == "thm":
            res = run_thm(lean, env, names, only, jobs)
            built = {}
        else:
            res, built = run_sol(lean, env, names, only, jobs)
            bok = sum(1 for v in built.values() if v == "ok")
            bfail = len(built) - bok
            print(f"  statement modules needed: {len(built)} ({bok} built, {bfail} not)")
            for m, v in list(built.items()):
                if v != "ok":
                    print(f"    {v[:110]}  ({m})")
        summarise(res, kind)
        allres[kind] = {"items": res, "statement_modules": built}

    json.dump(allres, open(OUT, "w"), indent=1)
    print(f"\nwrote {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())