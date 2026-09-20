#!/usr/bin/env python3
"""Compile all def bundles and report errors."""
import subprocess
import os
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEAN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.28.0/bin/lean"
ML_PKG = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake"
ML = f"{ML_PKG}/build/lib/lean"
BT = f"{ML_PKG}/packages/batteries/.lake/build/lib/lean"
QQ = f"{ML_PKG}/packages/Qq/.lake/build/lib/lean"
AQ = f"{ML_PKG}/packages/aesop/.lake/build/lib/lean"
PW = f"{ML_PKG}/packages/proofwidgets/.lake/build/lib/lean"
IG = f"{ML_PKG}/packages/importGraph/.lake/build/lib/lean"
LSC = f"{ML_PKG}/packages/LeanSearchClient/.lake/build/lib/lean"
PL = f"{ML_PKG}/packages/plausible/.lake/build/lib/lean"
LB = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.28.0/lib/lean"
PB = f"{WS}/.lake/build/lib/lean"

def get_lean_path():
    return f"{PB}:{ML}:{BT}:{QQ}:{AQ}:{PW}:{IG}:{LSC}:{PL}:{LB}"


def compile_def(def_name):
    olean_path = f"{PB}/Definitions/Def_{def_name}.olean"
    if os.path.exists(olean_path):
        return True, ""
    env = os.environ.copy()
    env["LEAN_PATH"] = get_lean_path()
    try:
        result = subprocess.run(
            [LEAN, f"{WS}/Definitions/Def_{def_name}.lean",
             "-o", olean_path],
            capture_output=True, text=True, timeout=120, env=env
        )
        output = result.stdout + result.stderr
        errors = [l for l in output.split("\n") if l.startswith("error:")]
        if errors:
            return False, "; ".join(errors[:3])
        return True, ""
    except subprocess.TimeoutExpired:
        return False, "TIMEOUT"


def main():
    # Get all def names
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
        if not success:
            # Retry once for timeouts
            time.sleep(2)
            success, err = compile_def(def_name)
        if success:
            ok += 1
            if (i + 1) % 20 == 0:
                print(f"Progress: {i+1}/{len(def_files)} ({ok} ok, {fail} fail)", flush=True)
        else:
            fail += 1
            fail_list.append((def_name, err))
            print(f"FAIL: {def_name}: {err}", flush=True)

    print(f"\n=== RESULTS ===")
    print(f"Total: {len(def_files)}, OK: {ok}, FAIL: {fail}")
    if fail_list:
        print("\nFailed defs:")
        for name, err in fail_list:
            print(f"  {name}: {err}")


if __name__ == "__main__":
    main()
