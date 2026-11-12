#!/usr/bin/env python3
"""Gate-loop: compile a def bundle, refresh whichever dependency it names, retry.

`refresh_stale_defs.py` walks the import closure but cannot know which *module*
declares a name the bundle uses -- when the mirror's olean for that module
predates the declaration, Lean says `Unknown identifier` and nothing in the
target is wrong.  This loop reads the error, finds the declaring module by
grepping the repo for a declaration line, refreshes just that module's olean,
and retries the bundle.  Bounded to --rounds retries per bundle; every error it
cannot attribute is reported.

One compile at a time (the OOM rule).
"""
import argparse
import json
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
DECL = re.compile(r"^(?:@\[\S*\]\s*)?(?:(?:private|protected|noncomputable|partial)\s+)*"
                  r"(?:theorem|lemma|def|abbrev|structure|inductive|class|instance)\s+(\S+)")


def build_index():
    idx = {}
    for f in sorted(os.listdir(os.path.join(WS, "Definitions"))):
        if not f.endswith(".lean"):
            continue
        p = os.path.join(WS, "Definitions", f)
        for line in open(p, encoding="utf-8", errors="ignore"):
            m = DECL.match(line)
            if m:
                idx.setdefault(m.group(1).strip(), p)
    return idx


def run_lean(relpath):
    # `relpath` arrives absolute from the declaration index and relative from the
    # target list.  Normalise it *and* refuse any path outside the mirror: the
    # first version of this tool did `os.path.join(MIRROR, abs_path)`, which is
    # the absolute path again, so refreshing a dependency opened the REPO file
    # `"w"` and truncated three repaired bundles to zero bytes (2026-11-12).
    rel = os.path.relpath(relpath, WS) if os.path.isabs(relpath) else relpath
    dst = os.path.join(MIRROR, rel)
    if not os.path.abspath(dst).startswith(os.path.abspath(MIRROR) + os.sep):
        raise SystemExit(f"refusing to write outside the mirror: {dst}")
    src_text = open(os.path.join(WS, rel), encoding="utf-8", errors="ignore").read()
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    open(dst, "w").write(src_text)
    base = subprocess.run(["lake", "env", "bash", "-c", 'printf %s "$LEAN_PATH"'],
                          cwd=PROJ, capture_output=True, text=True).stdout.strip()
    lean = subprocess.run(["bash", "-c", "command -v lean"], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()
    env = dict(os.environ, LEAN_PATH=f"{MIRROR}:{base}",
               PATH=PATH_BIN + ":" + os.environ["PATH"])
    module = rel[:-5]
    r = subprocess.run([lean, "-DautoImplicit=false", "-o", module + ".olean",
                        module + ".lean"],
                       cwd=MIRROR, env=env, capture_output=True, text=True,
                       timeout=int(os.environ.get("REGATE_TIMEOUT", "1800")))
    return r.returncode, r.stdout + r.stderr


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--targets-file", required=True)
    ap.add_argument("--rounds", type=int, default=4)
    a = ap.parse_args()
    idx = build_index()
    targets = [l.strip() for l in open(a.targets_file) if l.strip()]
    out = {}
    for t in targets:
        rel = t if t.endswith(".lean") else f"Definitions/Def_{t}.lean"
        if not os.path.exists(os.path.join(WS, rel)):
            out[t] = "NOSRC"
            continue
        status = "?"
        for rnd in range(a.rounds):
            rc, log = run_lean(rel)
            if rc == 0:
                status = "OK"
                break
            unknown = re.findall(r"Unknown identifier `([^`]+)`", log)
            missing = re.findall(r"Unknown constant `([^`]+)`", log)
            names = [n.split(".")[-1] for n in unknown + missing]
            # `object file ... does not exist` = the import resolves to a module
            # the mirror never built (a stub the bundle just started importing).
            # Build it instead of guessing at a declaration name.
            deps = []
            for n in re.findall(r"object file '([^']+)\.olean' of module", log):
                n = os.path.normpath(n)
                if n.startswith(os.path.abspath(MIRROR) + os.sep):
                    deps.append(os.path.relpath(n, MIRROR) + ".lean")
            for n in dict.fromkeys(names):
                p = idx.get(n)
                if p and os.path.basename(p) != os.path.basename(rel) and p not in deps:
                    deps.append(p)
            if not deps:
                status = "FAIL " + next(
                    (l for l in log.splitlines() if "error" in l), "").strip()[:260]
                break
            print(f"  {t}: refreshing {len(deps)} dep(s): "
                  f"{[os.path.basename(d) for d in deps]}", flush=True)
            for d in deps:
                rc2, log2 = run_lean(d)
                if rc2 != 0:
                    print(f"    dep itself fails: {os.path.basename(d)} "
                          f"{next((l for l in log2.splitlines() if 'error' in l), '')[:150]}",
                          flush=True)
        out[t] = status
        print(f"{status[:12]:12s} {t}", flush=True)
    json.dump(out, open("/tmp/gate_loop_result.json", "w"), indent=1)


if __name__ == "__main__":
    sys.exit(main())
