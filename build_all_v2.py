#!/usr/bin/env python3
"""Build def bundles with configurable timeout per module."""
import os, re, subprocess, sys, time

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

dep_count = {db: len(deps[db]) for db in def_bundles}
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

built = set()
for f in os.listdir(".lake/build/lib/lean/Definitions"):
    if f.startswith("Def_Chapter") and f.endswith(".olean"):
        built.add(f.replace(".olean", ""))

print(f"Topological order: {total} modules ({len(built)} already built)", flush=True)

built_count = 0
skip_count = 0
fail_count = 0

for i, db in enumerate(order):
    modname = db.replace(".lean", "")
    if modname in built:
        skip_count += 1
        continue

    cmd = [BUILD_SCRIPT, db]
    t0 = time.time()
    sys.stdout.write(f"\n[{i+1}/{total}] BUILDING: {db} ...\n")
    sys.stdout.flush()
    try:
        result = subprocess.run(cmd, timeout=900)
    except subprocess.TimeoutExpired:
        sys.stdout.write(f"[{i+1}/{total}] TIMEOUT (900s): {db}\n")
        sys.stdout.flush()
        fail_count += 1
        continue

    elapsed = time.time() - t0
    if result.returncode == 0:
        built_count += 1
        sys.stdout.write(f"[{i+1}/{total}] OK ({elapsed:.0f}s): {db}\n")
        sys.stdout.flush()
    else:
        fail_count += 1
        sys.stdout.write(f"[{i+1}/{total}] FAIL ({elapsed:.0f}s): {db}\n")
        sys.stdout.flush()

print(f"\n=== SUMMARY ===", flush=True)
print(f"Built: {built_count}, Skipped: {skip_count}, Failed: {fail_count}", flush=True)
