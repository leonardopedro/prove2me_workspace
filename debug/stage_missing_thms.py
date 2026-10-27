#!/usr/bin/env python3
"""Stage missing `Theorems.*` stub oleans into /tmp/published_mirror.

check_sol_local/check_def_local mirror the platform's environment, but the
mirror only carries oleans for stubs that were staged when it was last built —
a stub created (or fixed) after that dies in local checks with
`object file ... does not exist` even though its source sits in Theorems/.

For every `import Theorems.X` of the given file(s): if
/tmp/published_mirror/Theorems/X.olean is absent, copy Theorems/X.lean into the
mirror and compile it there (mirror on LEAN_PATH, so its Def oleans resolve).

Usage:
  python3 debug/stage_missing_thms.py Solutions/Sol_....lean [more.lean ...]
"""
import os
import re
import shutil
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = "/tmp/published_mirror"


def lean_env():
    sys.path.insert(0, os.path.join(WS, "debug"))
    import check_pending_offline as cpo
    return cpo.lean_env()


def stage(path):
    lean, env_path = lean_env()
    text = open(path, encoding="utf-8").read()
    mods = re.findall(r"^\s*import\s+(Theorems\.\S+)", text, re.M)
    missing = []
    for m in mods:
        name = m.split(".", 1)[1]
        olean = os.path.join(MIRROR, "Theorems", name + ".olean")
        if os.path.exists(olean):
            continue
        src = os.path.join(WS, "Theorems", name + ".lean")
        if not os.path.exists(src):
            print(f"  no source for {name}")
            continue
        shutil.copy2(src, os.path.join(MIRROR, "Theorems", name + ".lean"))
        env = dict(os.environ)
        env["LEAN_PATH"] = MIRROR + ":" + env_path
        r = subprocess.run(
            [lean, "-DautoImplicit=false", "-o", olean,
             os.path.join(MIRROR, "Theorems", name + ".lean")],
            cwd=MIRROR, env=env, capture_output=True, text=True, timeout=600)
        if r.returncode != 0:
            err = next((l for l in (r.stdout + r.stderr).splitlines()
                        if "error" in l), "?")
            print(f"  stub FAIL {name}: {err[:160]}")
        else:
            missing.append(name)
    print(f"  staged {len(missing)} stub(s) for {os.path.basename(path)}")


def main():
    for p in sys.argv[1:]:
        stage(p)
    return 0


if __name__ == "__main__":
    sys.exit(main())
