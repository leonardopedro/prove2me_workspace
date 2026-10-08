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
    ap.add_argument("--thm-out", default=None,
                    help="also write the theorem stubs that compiled, as bare slugs")
    a = ap.parse_args()

    targets = [l.strip() for l in open(a.targets) if l.strip()]
    os.makedirs(f"{MIRROR}/Definitions", exist_ok=True)
    os.makedirs(f"{MIRROR}/Theorems", exist_ok=True)

    # stage: (1) EVERY workspace definition -- a bundle that is neither
    # published nor a target still must exist for importers to resolve;
    # mirrors used to rely on leftovers from earlier runs, so a fresh mirror
    # produced `object file ... not found` cascades.  (2) published bundles
    # OVERWRITE with the platform's verbatim text (authoritative for
    # dependents).  (3) targets last: the bundles under validation keep their
    # WS text even when a published copy exists.
    for f in sorted(os.listdir(f"{WS}/Definitions")):
        if f.endswith(".lean"):
            open(f"{MIRROR}/Definitions/{f}", "w").write(open(f"{WS}/Definitions/{f}").read())
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

    # theorem stubs any staged def (or staged stub) imports -- the closure,
    # not just the targets': the topo pass compiles EVERY staged def, and one
    # unresolvable `import Theorems.Thm_X` fails that bundle and cascades.
    need_thm = set()
    changed = True
    while changed:
        changed = False
        for f in os.listdir(f"{MIRROR}/Definitions"):
            if f.endswith(".lean"):
                for m in imports_of(f"{MIRROR}/Definitions/{f}", "Theorems"):
                    if m not in need_thm:
                        need_thm.add(m)
                        changed = True
        for m in sorted(need_thm):
            src = f"{WS}/Theorems/{m}.lean"
            if os.path.exists(src):
                mp = f"{MIRROR}/Theorems/{m}.lean"
                if not os.path.exists(mp):
                    open(mp, "w").write(open(src).read())
                    changed = True
                for n in imports_of(mp, "Theorems"):
                    if n not in need_thm:
                        need_thm.add(n)
                        changed = True
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
            r = subprocess.run([lean, "-DautoImplicit=false", "-o", f"{kind}/{m}.olean", p], cwd=MIRROR,
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
    tdeps = {m: [x for x in imports_of(f"{MIRROR}/Theorems/{m}.lean", "Definitions")
                 if x in all_defs] for m in thm_mods}

    # ONE topological pass over Definitions u Theorems.
    #
    # The previous version compiled every Theorems stub first, then the defs. But a
    # theorem stub IMPORTS the Definitions it needs, so on a cold mirror all 112
    # failed with `object file .../Definitions/Def_X.olean not found` and 0/112
    # compiled -- which then marked 43 def bundles BLOCKED for no reason. The real
    # dependency graph is three-way (def->def, thm->def, def->thm), so sort all of
    # it together and compile in that order.
    universe = {("D", m) for m in all_defs} | {("T", m) for m in thm_mods}
    udeps = {}
    for kind, mods in (("D", all_defs), ("T", thm_mods)):
        src = "Definitions" if kind == "D" else "Theorems"
        for m in mods:
            p = f"{MIRROR}/{src}/{m}.lean"
            # A GENERATOR inside a list is a list holding one useless element,
            # so the def->thm edges were silently dropped and 26 bundles
            # regressed from OK to FAIL. Both directions must be real lists.
            udeps[(kind, m)] = (
                [("T", x) for x in imports_of(p, "Theorems") if x in thm_mods]
                + [("D", x) for x in (ddeps if kind == "D" else tdeps)[m]]
            )

    # Full compiler output per bundle. The TSV cell used to be truncated at
    # 100 chars, which cut off the failing identifier (`unknown identifier
    # 'multOp_comm'` etc.) and made content FAILs undebuggable from the report
    # alone -- every one had to be recompiled by hand to see what broke.
    logdir = (a.report + ".logs") if a.report else "/tmp/build_candidate_logs"
    os.makedirs(logdir, exist_ok=True)

    dres, thm_res = {}, {}
    for kind, m in topo(sorted(universe), lambda k: udeps[k]):
        src = "Definitions" if kind == "D" else "Theorems"
        p = f"{MIRROR}/{src}/{m}.lean"
        if not os.path.exists(p):
            (dres if kind == "D" else thm_res)[m] = "NOSRC"
            continue
        r = subprocess.run([lean, "-DautoImplicit=false", "-o", f"{src}/{m}.olean", f"{src}/{m}.lean"],
                           cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                           capture_output=True, text=True, timeout=1800)
        out = r.stdout + r.stderr
        if r.returncode == 0:
            res = "OK"
        else:
            errline = next((l for l in out.splitlines() if "error" in l), "")
            # Single-line cell, no tabs (TSV); identifier-visible width.
            res = "FAIL " + errline.strip().replace("\t", " ")[:300]
            with open(f"{logdir}/{m}.log", "w") as fh:
                fh.write(out)
        if kind == "D":
            dres[m] = res
        else:
            thm_res[m] = res
    ok_thm = {m for m, v in thm_res.items() if v == "OK"}
    print(f"Theorems: {len(ok_thm)}/{len(thm_mods)} compiled")

    # A def whose theorem import did not build is BLOCKED, not FAILed: different
    # problem, and conflating them hid the real errors.
    for m in all_defs:
        if dres.get(m) in (None, "NOSRC"):
            continue
        missing = [t for t in imports_of(f"{MIRROR}/Definitions/{m}.lean", "Theorems")
                   if t not in ok_thm]
        if missing:
            dres[m] = f"BLOCKED by {missing[0]}"

    # ...and a def whose DEF import did not build is BLOCKED too.  Without
    # this, build133 reported 68 `object file ... not found` rows that were
    # pure cascade from 19 root content failures -- noise that hid the real
    # error list.  Any non-OK dep (FAIL or BLOCKED) blocks the dependent.
    for m in sorted(all_defs, reverse=True):
        if dres.get(m) in (None, "NOSRC"):
            continue
        bad = [d for d in ddeps.get(m, []) if dres.get(d) != "OK"]
        if bad:
            dres[m] = f"BLOCKED by {bad[0]}"

    ok = sorted(m[len("Def_"):] for m in cand if dres.get(m) == "OK")
    # The theorem stubs that DID build are publishable in their own right.
    # Write SLUGS, not module ids. Writing `Thm_<slug>` made every --only-file
    # round produce `Thm_Thm_<slug>`, and all 42 failed on `no such file` --
    # a harness bug reported as 42 content failures.
    okth = sorted(m[len("Thm_"):] if m.startswith("Thm_") else m for m in ok_thm)
    print(f"candidate defs OK: {len(ok)}/{len(targets)}")
    if a.report:
        with open(a.report, "w") as fh:
            for t in targets:
                fh.write(f"{dres.get('Def_' + t, 'NOSRC')}\t{t}\n")
    open("/tmp/cand_ok.txt", "w").write("\n".join(ok) + "\n")
    if a.thm_out:
        open(a.thm_out, "w").write("\n".join(okth) + "\n")

    # Durable per-bundle gate for upload_pipeline.def_gate_fresh: the pipeline
    # cannot compile a def bundle itself (local_compile degrades to a skip when
    # its imports are not built in this checkout), so without this file a
    # `--kind def` chunk submits compile-FAIL bundles straight into the
    # 5-attempt budget.  stamp = sha1 of the WS bundle, the same fingerprint
    # upload_pipeline.file_stamp computes, so an edit after the build invalidates
    # the gate.  Merge, don't replace: a later build with fewer targets must not
    # erase verdicts for chapters it never covered.
    gate_path = os.path.join(WS, "state", "def_gate.json")
    try:
        gate = json.load(open(gate_path))
        if not isinstance(gate, dict):
            gate = {}
    except (OSError, ValueError):
        gate = {}
    for t in targets:
        p = f"{WS}/Definitions/Def_{t}.lean"
        try:
            stamp = hashlib.sha1(open(p, "rb").read()).hexdigest()[:16]
        except OSError:
            stamp = None
        gate[t] = {"status": dres.get("Def_" + t, "NOSRC"), "stamp": stamp}
    gate["_meta"] = {"generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
                     "run_targets": len(targets)}
    json.dump(gate, open(gate_path, "w"), indent=1)
    okb = sum(1 for t in targets
              if (gate.get(t) or {}).get("status") == "OK")
    print(f"def gate written: {gate_path} ({okb}/{len(targets)} targets OK)")


if __name__ == "__main__":
    sys.exit(main())
