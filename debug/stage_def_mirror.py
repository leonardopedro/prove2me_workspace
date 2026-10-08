#!/usr/bin/env python3
"""Stage newly-published def bundles into the offline mirror.

The offline oracle's static pre-check (`unpublished def import X`) tests for
`/tmp/published_mirror/Definitions/Def_X.lean`, and every thm/sol compile
resolves `Definitions.*` from the mirror (it is first on LEAN_PATH).  A def
bundle published through the platform is NOT in the mirror until this runs, so
its importers keep a stale `FAIL:unpublished def import` verdict forever.

Only ADDS modules; never touches an existing mirror file (the mirror is the
copy of the platform's world, §6.4).  Missing `Theorems.Thm_*` modules the
bundle imports are staged and compiled first (deps-first over the import graph).

Usage:
  python3 debug/stage_def_mirror.py ChapterPvmMeasure ChapterSymmetryRep ...
"""
import os
import re
import shutil
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = "/tmp/published_mirror"
IMPORT_RE = re.compile(r"^import\s+(Theorems\.\S+|Definitions\.\S+)", re.M)


def lake(script):
    return subprocess.run(["lake", "env", "bash", "-c", script], cwd=WS,
                          capture_output=True, text=True).stdout.strip()


def imports_of(path):
    try:
        txt = open(path, encoding="utf-8").read()
    except OSError:
        return []
    return IMPORT_RE.findall(txt)


def local_path(mod):
    """Local source for a Theorems.*/Definitions.* module."""
    sub, _, name = mod.partition(".")
    return os.path.join(WS, sub, name + ".lean")


def mirror_has(mod, ext):
    sub, _, name = mod.partition(".")
    return os.path.exists(os.path.join(MIRROR, sub, name + ext))


def main():
    chapters = sys.argv[1:]
    if not chapters:
        print(__doc__)
        return 2
    lean = lake("command -v lean")
    base = lake('printf %s "$LEAN_PATH"')
    if not lean or not base:
        print("could not read the Lean environment from `lake env`")
        return 2
    env = dict(os.environ, LEAN_PATH=MIRROR + ":" + base)

    # Seed the queue with the requested def bundles, then BFS their imports.
    # PRUNE at a module the mirror already carries as an .olean: its own deps
    # are satisfied (it compiled against them), so descending into the full
    # transitive closure only stages Thm sources nothing needs -- the mirror
    # must stay as close to "published modules only" as possible.
    queue = [f"Definitions.Def_{c}" for c in chapters]
    needed = []          # deps-first: imports before importers
    seen = set()
    while queue:
        mod = queue.pop(0)
        if mod in seen:
            continue
        seen.add(mod)
        if mirror_has(mod, ".olean"):
            continue
        src = local_path(mod)
        if not os.path.exists(src):
            print(f"  LOCAL SOURCE MISSING for {mod}: {src}")
            continue
        for dep in imports_of(src):
            if dep.startswith(("Theorems.", "Definitions.")) and dep not in seen:
                queue.append(dep)
        needed.append(mod)

    # needed[] currently has importers before imports (BFS); compile in
    # REVERSE discovery order so a dependency staged later still precedes its
    # importer -- for the shallow graphs here reverse-BFS == deps-first.
    failures = []
    for mod in reversed(needed):
        sub, _, name = mod.partition(".")
        dst_dir = os.path.join(MIRROR, sub)
        os.makedirs(dst_dir, exist_ok=True)
        src = local_path(mod)
        dst_lean = os.path.join(dst_dir, name + ".lean")
        if not os.path.exists(dst_lean):
            shutil.copy2(src, dst_lean)
            print(f"  staged {mod}.lean")
        olean = os.path.join(dst_dir, name + ".olean")
        if os.path.exists(olean):
            print(f"  ok     {mod} (olean present)")
            continue
        r = subprocess.run(
            [lean, "-DautoImplicit=false", "-o", f"{sub}/{name}.olean",
             f"{sub}/{name}.lean"],
            cwd=MIRROR, env=env, capture_output=True, text=True, timeout=900)
        if r.returncode == 0:
            print(f"  built  {mod}")
        else:
            out = (r.stdout + r.stderr).strip().splitlines()
            err = next((l for l in out if "error" in l), out[0] if out else "?")
            print(f"  FAIL   {mod}: {err[:200]}")
            failures.append((mod, err))
    print(f"\nstaged {len(needed) - len(failures)}/{len(needed)} module(s)")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
