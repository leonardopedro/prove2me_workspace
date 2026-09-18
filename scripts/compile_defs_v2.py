#!/usr/bin/env python3
"""Compile all def bundles and report errors. Uses lean directly with minimal LEAN_PATH."""
import subprocess
import os
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEAN = "/home/leo/.elan/toolchains/leanprover--lean4---v4.28.0/bin/lean"
ML_PKG = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake"
ML = f"{ML_PKG}/build/lib/lean"
LB = "/home/leo/.elan/toolchains/leanprover--lean4---v4.28.0/lib/lean"
PB = f"{WS}/.lake/build/lib/lean"

# Minimal LEAN_PATH: just mathlib + project + lean lib
# Batteries/Qq/etc are subdirs of mathlib so their oleans are found via Mathlib.*
LEAN_PATH = f"{PB}:{ML}:{LB}"

def compile_def(def_name):
    olean_path = f"{PB}/Definitions/Def_{def_name}.olean"
    if os.path.exists(olean_path):
        return True, ""
    env = os.environ.copy()
    env["LEAN_PATH"] = LEAN_PATH
    try:
        result = subprocess.run(
            [LEAN, f"{WS}/Definitions/Def_{def_name}.lean",
             "-o", olean_path],
            capture_output=True, text=True, timeout=300, env=env
        )
        output = result.stdout + result.stderr
        errors = [l for l in output.split("\n") if l.startswith("error:")]
        if errors:
            return False, "; ".join(errors[:3])
        return True, ""
    except subprocess.TimeoutExpired:
        return False, "TIMEOUT"


def main():
    def_dir = f"{WS}/Definitions"
    def_files = sorted([
        f.replace(".lean", "").replace("Def_", "")
        for f in os.listdir(def_dir)
        if f.startswith("Def_") and f.endswith(".lean")
    ])

    ok = 0
    fail = 0
    fail_list = []

    for i, def_name in enumerate(def_files):
        success, err = compile_def(def_name)
        if success:
            ok += 1
            if (i + 1) % 30 == 0:
                print(f"Progress: {i+1}/{len(def_files)} ({ok} ok, {fail} fail)", flush=True)
        else:
            fail += 1
            fail_list.append((def_name, err))
            print(f"FAIL: {def_name}: {err}", flush=True)

    print(f"\n=== RESULTS ===", flush=True)
    print(f"Total: {len(def_files)}, OK: {ok}, FAIL: {fail}", flush=True)
    if fail_list:
        print("\nFailed defs:", flush=True)
        for name, err in fail_list:
            print(f"  {name}: {err}", flush=True)


if __name__ == "__main__":
    main()
