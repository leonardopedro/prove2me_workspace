#!/usr/bin/env python3
"""Build def bundles in topological order using correct LEAN_PATH."""
import os, re, subprocess, sys

WS = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
os.chdir(WS)

# Resolve HOME (workspace .elan may not exist; lean lives in ~/.elan/)
HOME = os.environ.get("HOME", os.path.expanduser("~"))

MATHLIB_PKG = f"{WS}/.lake/packages/mathlib"

# Collect all lean lib dirs from .lake/packages/*/ and mathlib
pkg_lib_dirs = []
for pkg_name in sorted(os.listdir(".lake/packages")):
    lib_dir = f".lake/packages/{pkg_name}/.lake/build/lib/lean"
    if os.path.isdir(lib_dir):
        pkg_lib_dirs.append(lib_dir)

# Also add mathlib's own build dir
mathlib_build = f"{MATHLIB_PKG}/.lake/build/lib/lean"
if os.path.isdir(mathlib_build):
    pkg_lib_dirs.append(mathlib_build)

# System lean stdlib
stdlib = f"{HOME}/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean"
LEAN_PATH = ":".join([
    f"{WS}/.lake/build/lib/lean",
    ":".join(pkg_lib_dirs),
    stdlib,
])

# Build environment: PATH + LEAN_PATH
BUILD_ENV = os.environ.copy()
BUILD_ENV["LEAN_PATH"] = LEAN_PATH
BUILD_ENV["PATH"] = f"{HOME}/.elan/toolchains/leanprover--lean4---v4.33.1/bin:{BUILD_ENV.get('PATH', '')}"

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
dep_count = {db: len(deps[db]) for db in def_bundles}

# Queue defs with no dependencies
queue = sorted([db for db in def_bundles if dep_count[db] == 0])
order = []

while queue:
    db = queue.pop(0)
    order.append(db)
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

    if modname in built:
        skip_count += 1
        continue

    # Build using `lake build` directly (not via build_one.sh)
    result = subprocess.run(
        ["lake", "build", f"Definitions.{modname}"],
        env=BUILD_ENV, capture_output=True, text=True, timeout=1800,
    )

    if result.returncode == 0:
        built_count += 1
        print(f"[{i+1}/{total}] OK: {db}", flush=True)
    else:
        output = (result.stdout + result.stderr).strip()
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
            print(f"[{i+1}/{total}] OK (verbose): {db}", flush=True)

print(f"\n=== SUMMARY ===", flush=True)
print(f"Built: {built_count}, Skipped (cached): {skip_count}, Failed: {fail_count}", flush=True)
for db, err in failures:
    print(f"  {db}: {err[:150]}", flush=True)
