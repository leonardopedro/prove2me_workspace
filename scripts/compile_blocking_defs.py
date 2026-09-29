#!/usr/bin/env python3
"""Compile blocking defs in dependency order."""
import subprocess
import os
import re
import time

LEAN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
WS = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
PB = f"{WS}/.lake/build/lib/lean"

def get_lean_path():
    return f"{PB}:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/batteries/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/Qq/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/aesop/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/proofwidgets/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/importGraph/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/plausible/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean"

def get_def_dependencies(def_name):
    filepath = f"{WS}/Definitions/Def_{def_name}.lean"
    if not os.path.exists(filepath):
        return set()
    deps = set()
    try:
        with open(filepath, 'r') as f:
            content = f.read()
        for match in re.finditer(r'import Definitions\.Def_(.+)', content):
            dep_name = match.group(1)
            deps.add(dep_name)
    except Exception as e:
        print(f"  Warning: could not read {filepath}: {e}")
    return deps

def compile_def(def_name, compiled, visited=None):
    if visited is None:
        visited = set()
    if def_name in compiled:
        return True, ""
    if def_name in visited:
        return True, ""
    visited.add(def_name)
    
    deps = get_def_dependencies(def_name)
    for dep in sorted(deps):
        success, err = compile_def(dep, compiled, visited)
        if not success:
            return False, f"dependency failed: {dep}"
    
    olean_path = f"{PB}/Definitions/Def_{def_name}.olean"
    if os.path.exists(olean_path):
        compiled.add(def_name)
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
        compiled.add(def_name)
        return True, ""
    except subprocess.TimeoutExpired:
        return False, "TIMEOUT"

if __name__ == "__main__":
    blocking_defs = [
        "ChapterQgTimeStepping", "ChapterQgManifoldModeInstance", "ChapterSirkSingleTimeShift",
        "ChapterYangMillsAbelianFockEsa", "ChapterYangMillsBandBounds", "ChapterFiniteSectionSingleTime",
        "ChapterScalaronOuterFockFL", "ChapterQgVielbeinModeInstance"
    ]

    all_needed = set()
    for def_name in blocking_defs:
        stack = [def_name]
        while stack:
            current = stack.pop()
            if current in all_needed:
                continue
            all_needed.add(current)
            for dep in get_def_dependencies(current):
                if dep not in all_needed:
                    stack.append(dep)

    print(f"Total defs to compile: {len(all_needed)}")
    print(f"Defs: {sorted(all_needed)}", flush=True)

    ok = 0
    fail = 0
    fail_list = []
    compiled = set()

    for i, def_name in enumerate(sorted(all_needed)):
        success, err = compile_def(def_name, compiled)
        if success:
            ok += 1
            if (i + 1) % 10 == 0:
                print(f"Progress: {i+1}/{len(all_needed)} ({ok} ok, {fail} fail)", flush=True)
        else:
            fail += 1
            fail_list.append((def_name, err))
            print(f"FAIL: {def_name}: {err}", flush=True)

    print(f"\n=== RESULTS ===", flush=True)
    print(f"Total: {len(all_needed)}, OK: {ok}, FAIL: {fail}", flush=True)
    if fail_list:
        print("\nFailed defs:", flush=True)
        for name, err in fail_list:
            print(f"  {name}: {err}", flush=True)
