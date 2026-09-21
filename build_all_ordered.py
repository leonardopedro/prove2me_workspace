#!/usr/bin/env python3
"""Build def bundles in topological order using correct LEAN_PATH."""
import os, re, subprocess, sys

WS = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
LEAN = f"{WS}/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
os.chdir(WS)

MATHLIB_PKG = f"{WS}/.lake/packages/mathlib"
LEAN_PATH = f"{WS}/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/batteries/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/Qq/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/aesop/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/proofwidgets/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/importGraph/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/LeanSearchClient/.lake/build/lib/lean:{MATHLIB_PKG}/.lake/packages/plausible/.lake/build/lib/lean:{WS}/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean"
os.environ["LEAN_PATH"] = LEAN_PATH

BUILD_SCRIPT = f"{WS}/build_one.sh"

def_bundles = sorted([f for f in os.listdir("Definitions") if f.startswith("Def_Chapter") and f.endswith(".lean")])

deps = {}
for db in def_bundles:
    path = os.path.join("Definitions", db)
    with open(path) as f:
        content = f.read()
    imports = re.findall(r"^import (Definitions\.\S+)", content, re.MULTILINE)
    dep_files = [m.replace("Definitions.", "") + ".lean" for m in imports if m.startswith("Definitions.")]
    deps[db] = [d for d in dep_files if d in set(def_bundles)]

# Track how many dependencies each def has (out-degree)
# defs with 0 dependencies can be built first
dep_count = {db: len(deps[db]) for db in def_bundles}

# Queue defs with no dependencies
queue = sorted([db for db in def_bundles if dep_count[db] == 0])
order = []

# For tracking: which defs have been built
built_set = set()

while queue:
    db = queue.pop(0)
    order.append(db)
    built_set.add(db)
    
    # Find all defs that depend on this one
    for other_db in def_bundles:
        if db in deps[other_db]:
            dep_count[other_db] -= 1
            if dep_count[other_db] == 0:
                queue.append(other_db)

total = len(order)
built_count = 0
skip_count = 0
fail_count = 0
failures = []

# Compute which modules are already built
built = set()
for f in os.listdir(".lake/build/lib/lean/Definitions"):
    if f.startswith("Def_Chapter") and f.endswith(".olean"):
        built.add(f.replace(".olean", ""))

print(f"Topological order: {total} modules ({len(built)} already built)", flush=True)

for i, db in enumerate(order):
    modname = db.replace(".lean", "")
    olean_dir = ".lake/build/lib/lean/Definitions"
    
    if modname in built:
        skip_count += 1
        continue
    
    cmd = [BUILD_SCRIPT, db, "-o", olean_dir]
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=180)
    
    if result.returncode == 0:
        built_count += 1
        print(f"[{i+1}/{total}] OK: {db}", flush=True)
    else:
        output = (result.stdout + result.stderr).strip()
        # Check if it's a real error (contains "error:" or "Error")
        has_real_error = any("error:" in l.lower() or "Error" in l for l in output.split("\n") if l.strip())
        if has_real_error:
            err_lines = [l.strip() for l in output.split("\n") if l.strip() and "warning" not in l.lower()]
            err = err_lines[-1][:200] if err_lines else "unknown"
            if "does not exist" in output:
                print(f"[{i+1}/{total}] MISSING DEP: {db}", flush=True)
            else:
                print(f"[{i+1}/{total}] ERROR: {db}: {err[:150]}", flush=True)
                fail_count += 1
                failures.append((db, err))
        else:
            # Just lean output, probably success with verbose logging
            print(f"[{i+1}/{total}] OK (verbose): {db}", flush=True)

print(f"\n=== SUMMARY ===", flush=True)
print(f"Built: {built_count}, Skipped (cached): {skip_count}, Failed: {fail_count}", flush=True)
for db, err in failures:
    print(f"  {db}: {err[:150]}", flush=True)
