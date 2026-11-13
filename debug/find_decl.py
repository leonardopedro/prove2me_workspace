#!/usr/bin/env python3
"""Locate which module in an import closure declares a given name.

Usage: find_decl.py <name> <start-module>...

Compiles a one-line probe (`import M` + `#check @name`) against the candidate
mirror for each module, shallowest first, and recurses into the imports of any
module whose closure *does* contain the name.  Reported hits are the shallowest
modules that still provide it, so the culprit is usually their own source.
"""
import os, re, subprocess, sys

MIRROR = os.environ["CANDIDATE_MIRROR"]
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
BASE = os.environ["LEAN_BASE"]


def probe(mod, name):
    src = f"{MIRROR}/__probe.lean"
    open(src, "w").write(f"import {mod}\n#check @{name}\n")
    r = subprocess.run(["lean", "-DautoImplicit=false", "__probe.lean"], cwd=MIRROR,
                       capture_output=True, text=True,
                       env=dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"],
                                LEAN_PATH=f"{MIRROR}:{BASE}"))
    out = r.stdout + r.stderr
    return "unknownIdentifier" not in out and "unknown constant" not in out, out


def imports_of(mod):
    p = os.path.join(MIRROR, mod.replace(".", "/") + ".lean")
    if not os.path.exists(p):
        return []
    return re.findall(r"^import (\S+)$", open(p, encoding="utf-8", errors="ignore").read(), re.M)


name, starts = sys.argv[1], sys.argv[2:]
seen, queue, found = set(), [(m, 0) for m in starts], []
while queue:
    mod, d = queue.pop(0)
    if mod in seen:
        continue
    seen.add(mod)
    ok, out = probe(mod, name)
    if not ok:
        print(f"  [{d}] {mod}: no")
        continue
    kids = imports_of(mod)
    sub = [k for k in kids if k not in seen]
    print(f"  [{d}] {mod}: YES  (own source mentions name: "
          f"{bool(re.search(r'(def|theorem|lemma) +' + re.escape(name.split('.')[-1]) + r'\\b', open(os.path.join(MIRROR, mod.replace('.', '/') + '.lean'), encoding='utf-8', errors='ignore').read()) if os.path.exists(os.path.join(MIRROR, mod.replace('.', '/') + '.lean')) else '')})")
    if not sub:
        found.append(mod)
    queue.extend((k, d + 1) for k in sub)
print("deepest providers:", found[:10])
