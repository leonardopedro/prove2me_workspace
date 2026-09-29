#!/usr/bin/env python3
"""Compile all def bundles in dependency order using topological sort."""
import re, os, subprocess, time, sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEAN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.28.0/bin/lean"
ML_PKG = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake"
ML = ML_PKG + "/build/lib/lean"
BT = ML_PKG + "/packages/batteries/.lake/build/lib/lean"
QQ = ML_PKG + "/packages/Qq/.lake/build/lib/lean"
AQ = ML_PKG + "/packages/aesop/.lake/build/lib/lean"
PW = ML_PKG + "/packages/proofwidgets/.lake/build/lib/lean"
IG = ML_PKG + "/packages/importGraph/.lake/build/lib/lean"
LSC = ML_PKG + "/packages/LeanSearchClient/.lake/build/lib/lean"
PL = ML_PKG + "/packages/plausible/.lake/build/lib/lean"
LB = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.28.0/lib/lean"
PB = WS + "/.lake/build/lib/lean"

def get_lean_path():
    return PB + ":" + ":".join([ML, BT, QQ, AQ, PW, IG, LSC, PL, LB])

def get_imports(def_name):
    path = WS + "/Definitions/Def_" + def_name + ".lean"
    try:
        with open(path) as f:
            content = f.read()
        imports = re.findall(r"import Definitions\.Def_(.+?)(?:\n|$)", content)
        return [imp.strip() for imp in imports if imp.strip()]
    except:
        return []

def build_deps(def_files):
    deps = {}
    for def_name in def_files:
        deps[def_name] = set(get_imports(def_name))
    return deps

def toposort(deps):
    all_nodes = set(deps.keys())
    for v in deps.values():
        all_nodes |= v
    in_degree = {n: 0 for n in all_nodes}
    for v in deps.values():
        for u in v:
            if u in in_degree:
                in_degree[u] += 1
    queue = sorted([n for n in all_nodes if in_degree[n] == 0])
    order = []
    while queue:
        n = queue.pop(0)
        order.append(n)
        for m, ms in deps.items():
            if n in ms and m not in order:
                in_degree[m] -= 1
                if in_degree[m] == 0:
                    queue.append(m)
    return order

def compile_def(def_name):
    olean_path = PB + "/Definitions/Def_" + def_name + ".olean"
    if os.path.exists(olean_path):
        return True, ""
    env = os.environ.copy()
    env["LEAN_PATH"] = get_lean_path()
    try:
        result = subprocess.run(
            [LEAN, WS + "/Definitions/Def_" + def_name + ".lean", "-o", olean_path],
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
    def_dir = WS + "/Definitions"
    def_files = sorted([
        f.replace(".lean", "").replace("Def_", "")
        for f in os.listdir(def_dir)
        if f.startswith("Def_") and f.endswith(".lean")
    ])
    deps = build_deps(def_files)
    order = toposort(deps)
    print("Topological order: " + str(len(order)) + " defs", flush=True)
    ok = 0
    fail = 0
    fail_list = []
    for i, def_name in enumerate(order):
        success, err = compile_def(def_name)
        if not success:
            time.sleep(2)
            success, err = compile_def(def_name)
        if success:
            ok += 1
            if (i + 1) % 20 == 0:
                print("Progress: " + str(i+1) + "/" + str(len(order)) + " (" + str(ok) + " ok, " + str(fail) + " fail)", flush=True)
        else:
            fail += 1
            fail_list.append((def_name, err))
            print("FAIL: " + def_name + ": " + err, flush=True)
    print("=== RESULTS ===", flush=True)
    print("Total: " + str(len(order)) + ", OK: " + str(ok) + ", FAIL: " + str(fail), flush=True)
    if fail_list:
        print("Failed defs:", flush=True)
        for name, err in fail_list:
            print("  " + name + ": " + err, flush=True)

if __name__ == "__main__":
    main()
