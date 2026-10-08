#!/usr/bin/env python3
"""Compile every ROOT failure in the candidate mirror and save full error text.

Root = a staged module whose own imports all produced oleans but which did
not (def bundle or theorem stub).  Cascade rows inherit from roots; fixing
the roots clears them.  Output: /tmp/root_errors/<module>.log (full lean
output) and a summary line per module on stdout.
"""
import os
import re
import subprocess
import time

MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/def_candidate")
WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
OUT = "/tmp/root_errors"
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
IMP = re.compile(r"^import\s+(Definitions\.\S+|Theorems\.\S+)", re.M)


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd],
                          cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def deps_have_olean(mod):
    src, name = mod.split(".")
    p = f"{MIRROR}/{src}/{name}.lean"
    if not os.path.exists(p):
        return False
    txt = open(p, encoding="utf-8", errors="ignore").read()
    for d in IMP.findall(txt):
        s, n = d.split(".")
        if not os.path.exists(f"{MIRROR}/{s}/{n}.olean"):
            return False
    return True


def main():
    os.makedirs(OUT, exist_ok=True)
    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])

    roots = []
    for src in ("Definitions", "Theorems"):
        for f in sorted(os.listdir(f"{MIRROR}/{src}")):
            if not f.endswith(".lean"):
                continue
            name = f[:-5]
            if os.path.exists(f"{MIRROR}/{src}/{name}.olean"):
                continue
            if deps_have_olean(f"{src}.{name}"):
                roots.append((src, name))
    print(f"root failures: {len(roots)}")

    for src, name in roots:
        t0 = time.time()
        r = subprocess.run(
            [lean, "-DautoImplicit=false", f"{src}/{name}.lean"],
            cwd=MIRROR, env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
            capture_output=True, text=True, timeout=1800)
        out = r.stdout + r.stderr
        with open(f"{OUT}/{name}.log", "w") as fh:
            fh.write(out)
        errs = [l for l in out.splitlines() if "error" in l]
        first = errs[0] if errs else "(no error line?)"
        print(f"{name}\t{time.time()-t0:.1f}s\t{first[:160]}")


if __name__ == "__main__":
    main()
