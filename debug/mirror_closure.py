#!/usr/bin/env python3
"""Build the /tmp/published_mirror oleans for a module set, recursively.

For every `Definitions.*` / `Theorems.*` module an offline check needs, if the
mirror lacks the .olean, stage the local source into TIMEPIECE_PROJ (lean
requires inputs under its root) and compile deps-first with
LEAN_PATH=mirror:base.  Sources are the same statement/def text the platform
serves for sorry-free/statement modules; modules with no local source are
reported, not faked.

Usage:
  python3 debug/mirror_closure.py --from-file files...   (grep imports from files)
  python3 debug/mirror_closure.py Definitions.Def_X Theorems.Thm_Y ...
"""
import argparse
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
PROJ = os.environ.get(
    "TIMEPIECE_PROJ",
    "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331")
MIRROR = "/tmp/published_mirror"
IMPORT_RE = re.compile(r"(?m)^import\s+((?:Definitions|Theorems)\.[A-Za-z0-9_'.]+)")


def lake_env(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def src_of(mod):
    sub, _, stem = mod.partition(".")
    p = os.path.join(WS, sub, stem + ".lean")
    return p if os.path.exists(p) else None


def olean_of(mod):
    return os.path.join(MIRROR, mod.replace(".", os.sep) + ".olean")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mods", nargs="*")
    ap.add_argument("--from-file", nargs="*", default=[])
    args = ap.parse_args()

    roots = list(args.mods)
    for f in args.from_file:
        txt = open(f, encoding="utf-8").read()
        roots += IMPORT_RE.findall(txt)
    roots = sorted(set(roots))
    if not roots:
        raise SystemExit("no modules requested")

    state = {}   # mod -> "building" | "done" | "missing"
    order = []
    cyc, missing = [], []

    def visit(mod):
        st = state.get(mod)
        if st == "done":
            return True
        if st == "building":
            cyc.append(mod)
            return False
        if st == "missing":
            return False
        if os.path.exists(olean_of(mod)):
            state[mod] = "done"
            return True
        src = src_of(mod)
        if not src:
            state[mod] = "missing"
            missing.append(mod)
            return False
        state[mod] = "building"
        ok = True
        for dep in IMPORT_RE.findall(open(src, encoding="utf-8").read()):
            if not visit(dep):
                ok = False
        if not ok:
            state[mod] = "missing"
            return False
        order.append((mod, src))
        state[mod] = "done"
        return True

    for m in roots:
        visit(m)

    if not order:
        print("nothing to build; missing:", missing or "none")
        return 1 if missing else 0

    base = lake_env('printf %s "$LEAN_PATH"')
    lean = lake_env("command -v lean")
    env = dict(os.environ, LEAN_PATH=MIRROR + ":" + base)
    built = failed = 0
    for mod, src in order:
        dst = os.path.join(PROJ, os.path.relpath(src, WS))
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copy(src, dst)
        out = olean_of(mod)
        os.makedirs(os.path.dirname(out), exist_ok=True)
        try:
            r = subprocess.run([lean, "-o", out, os.path.relpath(dst, PROJ)],
                               cwd=PROJ, env=env, capture_output=True,
                               text=True, timeout=300)
            if r.returncode == 0 or os.path.exists(out):
                built += 1
                print("built  %s" % mod)
            else:
                failed += 1
                first = next((l for l in (r.stdout + r.stderr).splitlines()
                              if "error" in l), "?")
                print("FAILED %s: %s" % (mod, first[:180]))
        finally:
            if os.path.exists(dst):
                os.remove(dst)
    print("summary: built=%d failed=%d missing-source=%d cyclic=%d"
          % (built, failed, len(missing), len(set(cyc))))
    for m in sorted(set(missing)):
        print("  no local source:", m)
    return 0 if failed == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
