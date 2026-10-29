#!/usr/bin/env python3
"""Full first-error output for a def bundle.

`debug/check_def_local.py` prints only the FIRST line containing "error", which
hides the rest of multi-line diagnostics (`Tactic \`rewrite\` failed: Did not
find an occurrence of the pattern` continues with the pattern on the next
line).  Same compile world as check_def_local (mirror oleans symlinked into a
scratch root, own text over the symlink, `-DautoImplicit=false`).

Usage: python3 debug/def_full_error.py ChapterGradedFock [more...]
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)

import check_def_local as cdl  # noqa: E402
import check_pending_offline as cpo  # noqa: E402


def main(chapters):
    lean, env_path = cpo.lean_env()
    if not lean:
        print("could not read the Lean environment from `lake env`")
        return 2
    for ch in chapters:
        path = os.path.join(WS, "Definitions", f"Def_{ch}.lean")
        if not os.path.exists(path):
            print(f"MISSING {ch}")
            continue
        scratch = tempfile.mkdtemp(prefix="deferr-")
        try:
            cdl.link_mirror_oleans(scratch)
            env = dict(os.environ)
            env["LEAN_PATH"] = scratch + ":" + env_path
            text = open(path, encoding="utf-8").read()
            for mod in re.findall(r"^\s*import\s+(Theorems\.\S+)", text, re.M):
                name = mod.split(".", 1)[1]
                stub = os.path.join(WS, "Theorems", name + ".lean")
                olean = os.path.join(scratch, "Theorems", name + ".olean")
                if not os.path.exists(stub):
                    continue
                if os.path.lexists(olean):
                    if not os.path.islink(olean):
                        continue
                    os.remove(olean)
                cdl.compile_one(lean, env, scratch, stub, "Theorems")
            dst = os.path.join(scratch, "Definitions", os.path.basename(path))
            shutil.copy2(path, dst)
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o",
                 os.path.join(scratch, "Definitions", os.path.basename(path)[:-5] + ".olean"),
                 dst],
                cwd=scratch, env=env, capture_output=True, text=True, timeout=900)
            out = (r.stdout + r.stderr).strip().splitlines()
            print(f"=== Def_{ch}  rc={r.returncode}")
            idx = next((i for i, l in enumerate(out) if "error" in l), None)
            if idx is None:
                print("  (no error lines)")
            else:
                for l in out[idx:idx + 8]:
                    print("  " + l)
        finally:
            shutil.rmtree(scratch, ignore_errors=True)
    return 0


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    sys.exit(main(sys.argv[1:]))
