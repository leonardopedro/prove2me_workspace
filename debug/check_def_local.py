#!/usr/bin/env python3
"""Compile-check a `Definitions/Def_*` bundle against the published mirror.

The offline oracle (check_pending_offline) only answers for thm/sol items; a
pending DEF bundle whose `publish FAILED: definition does not compile` has no
offline gate, so the defect is only discoverable by burning a platform publish
job.  This runs the same compile the platform runs, in a scratch root that is a
*superset* of the mirror's oleans.

Why the scratch links the mirror's oleans instead of just putting the mirror on
LEAN_PATH: Lean's `findWithExt` resolves a module against the FIRST search-path
entry where the package directory exists, with no fallback -- a scratch root
that merely contains `Definitions/` captures every `Definitions.*` lookup, so a
module absent from it dies with `object file ... does not exist` even though the
mirror has its olean (the §2.36 shadowing bug).  Symlinks keep the mirror the
single source of truth; our own text overwrites the symlink for the bundle under
test, and nothing is ever written back into the mirror.

Usage:
  python3 debug/check_def_local.py ChapterWallDeficiencyObstruction [more...]
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

import check_pending_offline as cpo  # noqa: E402


def link_mirror_oleans(scratch):
    """Make each scratch subpackage a superset of the mirror's oleans."""
    for sub in ("Theorems", "Definitions"):
        os.makedirs(os.path.join(scratch, sub), exist_ok=True)
        src = os.path.join(cpo.MIRROR, sub)
        if not os.path.isdir(src):
            continue
        for ent in os.listdir(src):
            if not ent.endswith(".olean"):
                continue
            dst = os.path.join(scratch, sub, ent)
            if not os.path.lexists(dst):
                os.symlink(os.path.join(src, ent), dst)


def compile_one(lean, env, scratch, src, sub):
    base = os.path.basename(src)
    dst = os.path.join(scratch, sub, base)
    shutil.copy2(src, dst)                    # overwrites the mirror symlink
    olean = os.path.join(scratch, sub, base[:-5] + ".olean")
    if os.path.exists(olean) and not os.path.islink(olean):
        os.remove(olean)
    r = subprocess.run([lean, "-DautoImplicit=false", "-o", olean, dst],
                       cwd=scratch, env=env, capture_output=True, text=True,
                       timeout=900)
    out = (r.stdout + r.stderr).strip().splitlines()
    err = next((l for l in out if "error" in l), None)
    return r.returncode == 0, err


def main(chapters):
    lean, env_path = cpo.lean_env()
    if not lean:
        print("could not read the Lean environment from `lake env`")
        return 2
    failed = []
    for ch in chapters:
        path = os.path.join(WS, "Definitions", f"Def_{ch}.lean")
        if not os.path.exists(path):
            print(f"  MISSING  {ch}")
            failed.append(ch)
            continue
        scratch = tempfile.mkdtemp(prefix="defcheck-")
        try:
            link_mirror_oleans(scratch)
            env = dict(os.environ)
            env["LEAN_PATH"] = scratch + ":" + env_path
            # The bundle's own Theorems.* imports must exist as oleans too;
            # compile the ones the scratch does not already carry.
            text = open(path, encoding="utf-8").read()
            imports = re.findall(r"^\s*import\s+(Theorems\.\S+)", text, re.M)
            for mod in imports:
                if not mod.startswith("Theorems."):
                    continue
                name = mod.split(".", 1)[1]
                olean = os.path.join(scratch, "Theorems", name + ".olean")
                if os.path.lexists(olean) and not os.path.islink(olean):
                    continue
                stub = os.path.join(WS, "Theorems", name + ".lean")
                if not os.path.exists(stub):
                    continue
                if os.path.lexists(olean):
                    os.remove(olean)
                ok, err = compile_one(lean, env, scratch, stub, "Theorems")
                if not ok:
                    print(f"  dep FAIL {name}: {(err or '')[:180]}")
            ok, err = compile_one(lean, env, scratch, path, "Definitions")
            print(f"  {'OK  ' if ok else 'FAIL'} Def_{ch}")
            if not ok:
                print(f"        {(err or '')[:300]}")
                failed.append(ch)
        finally:
            shutil.rmtree(scratch, ignore_errors=True)
    print(f"\n{len(chapters) - len(failed)}/{len(chapters)} def bundle(s) compile")
    if failed:
        print("failed: " + ", ".join(failed))
    return 1 if failed else 0


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    sys.exit(main(sys.argv[1:]))
