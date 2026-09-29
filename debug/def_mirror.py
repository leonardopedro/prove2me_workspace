#!/usr/bin/env python3
"""Compile ONE `Definitions/Def_<Chapter>.lean` bundle in a mirror of the platform's tree.

THE PROBLEM THIS SOLVES
-----------------------
The platform compiles a def bundle against **only the bundles that are already
published** -- nothing else is on the import path.  So a bundle can fail there
while looking fine in a checkout that has the whole `Definitions/` tree, and the
only way to learn the truth has been to spend one of the bundle's five upload
attempts.  That is too expensive for iterating on a rewrite.

This tool reproduces the platform's world locally:

* a scratch mirror holds only the def bundles listed in `state/defs_published.json`
  (plus the root bundle under test), so `import Definitions.Def_X` for an
  unpublished `X` fails exactly as it does server-side;
* the published bundles are compiled to oleans in dependency order;
* the root module is compiled last and every diagnostic is printed verbatim.

`lake env` supplies the toolchain and Mathlib, so run it from the Lean project
(`$TIMEPIECE_PROJ`); the tool does that itself.

USAGE
-----
    python3 debug/def_mirror.py ChapterDirectSumEsa
    python3 debug/def_mirror.py --keep-temp ChapterDirectSumEsa
"""
import argparse
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = (os.environ.get("PROVE2ME_WS")
      or os.path.dirname(HERE)
      or "/home/leo/prove2me_workspace")
PROJ = os.environ.get("TIMEPIECE_PROJ") or os.environ.get("PROVE2ME_PROJ") or ""
INDEX = os.path.join(WS, "state", "defs_index.json")
PUBLISHED = os.path.join(WS, "state", "defs_published.json")
MIRROR = os.environ.get("DEF_MIRROR") or "/tmp/def_mirror"


def published_set():
    """The bundles the platform has PUBLISHED.

    `defs_index.json` is built from the platform's own publish jobs (by
    `debug/platform_def_index.py`), so it is the truth to mirror; the flat
    `defs_published.json` list is a cache the pipeline writes and it drifts (it
    is refreshed only when the pipeline runs, so a bundle published by hand —
    or by an earlier `--sync` — stays missing and the mirror would withhold a
    bundle the platform already accepts, reproducing an error that is gone).
    """
    if os.path.exists(INDEX):
        idx = json.load(open(INDEX, encoding="utf-8"))
        return {b for b, rec in idx.get("bundles", {}).items()
                if rec.get("status") == "PUBLISHED"}
    return set(json.load(open(PUBLISHED, encoding="utf-8")))


def imports_of(path):
    out = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            m = re.match(r"^import\s+Definitions\.Def_(\S+)", line)
            if m:
                out.append(m.group(1))
    return out


def topological(root, avail):
    """Deps-first order of `avail` bundles reachable from `root` (root excluded)."""
    seen, order = set(), []

    def visit(n, is_root=False):
        # The root is not published (that is the whole point), so it must be
        # walked even though `avail` does not contain it.
        if n in seen or (not is_root and n not in avail):
            return
        seen.add(n)
        for d in imports_of(os.path.join(MIRROR, "Definitions", f"Def_{n}.lean")):
            visit(d)
        if not is_root:
            order.append(n)

    visit(root, is_root=True)
    return order


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("chapter", help="the Chapter part: Def_<chapter>.lean")
    ap.add_argument("--keep-temp", action="store_true", help="do not delete the mirror")
    ap.add_argument("--rebuild-deps", action="store_true",
                    help="recompile published deps even if their olean is fresh")
    ap.add_argument("--reuse", action="store_true",
                    help="keep the mirror and its oleans: re-runs only compile what is stale, "
                         "which is what makes a cold 130-bundle run survivable")
    args = ap.parse_args()

    root_src = os.path.join(WS, "Definitions", f"Def_{args.chapter}.lean")
    if not os.path.exists(root_src):
        print(f"missing bundle: {root_src}")
        return 2
    if not PROJ:
        print("set TIMEPIECE_PROJ to the Lean project that owns the toolchain")
        return 2

    pub = published_set()
    if not args.reuse:
        shutil.rmtree(MIRROR, ignore_errors=True)
    os.makedirs(os.path.join(MIRROR, "Definitions"), exist_ok=True)
    copied = skipped = 0
    for f in sorted(os.listdir(os.path.join(WS, "Definitions"))):
        if not (f.startswith("Def_") and f.endswith(".lean")):
            continue
        name = f[len("Def_"):-len(".lean")]
        src = os.path.join(WS, "Definitions", f)
        dst = os.path.join(MIRROR, "Definitions", f)
        if name == args.chapter or name in pub:
            if args.reuse and os.path.exists(dst) and \
                    os.path.getmtime(dst) >= os.path.getmtime(src):
                copied += 1
            else:
                shutil.copy2(src, dst)
                for stale in (dst[:-5] + ".olean", dst[:-5] + ".ilean"):
                    if os.path.exists(stale):
                        os.remove(stale)
                copied += 1
        else:
            skipped += 1
    print(f"mirror: {copied} bundle(s) present "
          f"({len(pub)} published + the root), {skipped} withheld as unpublished",
          flush=True)

    # `lake env` sets LEAN_PATH itself and refuses a source file outside the
    # package root, so the toolchain is captured from the lake environment once
    # and then the Lean binary is driven directly, with the mirror PREPENDED to
    # LEAN_PATH (a `-R` root does not affect import resolution).
    def lake_env_sh(script):
        return subprocess.run(["lake", "env", "bash", "-c", script], cwd=PROJ,
                              capture_output=True, text=True).stdout.strip()

    base_path = lake_env_sh('printf %s "$LEAN_PATH"')
    lean_bin = lake_env_sh('command -v lean')
    if not base_path or not lean_bin:
        print("could not read the Lean environment from `lake env` (is PROJ a Lean project?)")
        return 2
    env = dict(os.environ)
    env["LEAN_PATH"] = MIRROR + ":" + base_path
    print(f"lean: {lean_bin}")

    def compile_one(name, required=True):
        src = os.path.join(MIRROR, "Definitions", f"Def_{name}.lean")
        olean = os.path.join(MIRROR, "Definitions", f"Def_{name}.olean")
        if not args.rebuild_deps and name != args.chapter and os.path.exists(olean):
            return True, ""
        if not os.path.exists(src):
            return False, f"unpublished dependency Definitions.Def_{name} is not in the mirror"
        t0 = time.time()
        r = subprocess.run([lean_bin, "-o", olean, src], cwd=MIRROR, env=env,
                           capture_output=True, text=True)
        dt = time.time() - t0
        if r.returncode != 0:
            return False, f"Def_{name}.lean ({dt:.1f}s)\n{r.stdout}{r.stderr}"
        print(f"  ok  Def_{name}.lean  {dt:.1f}s", flush=True)
        return True, ""

    order = topological(args.chapter, pub)
    print(f"published deps reachable from the root (deps-first): {len(order)}", flush=True)
    for n in order:
        ok, msg = compile_one(n)
        if not ok:
            print(f"\nDEPENDENCY FAILURE\n{msg}")
            return 1
        pass

    print(f"\n=== compiling the root: Def_{args.chapter}.lean ===")
    ok, msg = compile_one(args.chapter)
    if ok:
        print("CLEAN: the mirror compiles this bundle the way the platform would")
        if not args.keep_temp:
            shutil.rmtree(MIRROR, ignore_errors=True)
        return 0
    print("FAILED\n")
    for line in msg.splitlines():
        if line.strip():
            print("  " + line)
    print("\nerrors as the platform would report them:")
    for line in re.findall(r"(?m)^.*error.*$", msg):
        print("  " + line.strip())
    print(f"\nmirror kept at {MIRROR} for inspection")
    return 1


if __name__ == "__main__":
    sys.exit(main())
