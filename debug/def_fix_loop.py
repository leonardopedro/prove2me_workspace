#!/usr/bin/env python3
"""Iterative first-error repair loop for a def bundle (the §2.4 method, scripted).

Compiles the bundle in the `check_def_local` world (mirror oleans symlinked into
a scratch root, workspace text over the symlink, `-DautoImplicit=false`) and
handles the ONE first error:

  * ``Unknown identifier `X```   -> find a ``Theorems/Thm_*`` stub declaring X
    (exact fully-qualified dotted name preferred, bare tail as fallback).  The
    stub's ``thm:`` AND ``sol:`` ledger records must BOTH be ``done`` (published
    and proved) -- a def may not cite an unproved theorem, and an unpublished
    import burns the publish attempt server-side.  Then append
    ``import Theorems.Thm_...`` and retry.
  * anything else               -> print it and stop (hand repair, §2.4).

Every rewrite is verified by a fresh compile, so an import that does not help
is reported rather than kept silently.  The mirror copy of the bundle is synced
from the workspace before every compile (the gate world reads the mirror).

Usage:
  python3 debug/def_fix_loop.py ChapterGradedFock [--max 8]
"""
import argparse
import json
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

MIRROR = os.environ.get("CANDIDATE_MIRROR", "/tmp/published_mirror")
DECL = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)?(?:theorem|lemma|def|abbrev|structure|class)\s+"
    r"([A-Za-z0-9_.ισℓ₂₃₀₁]*)\b", re.M)


def ledger():
    return json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]


def stub_for(ident, items):
    """A Thm stub declaring `ident` whose thm: and sol: records are both done."""
    tail = ident.split(".")[-1]
    hits = []
    for fn in sorted(os.listdir(os.path.join(WS, "Theorems"))):
        if not fn.startswith("Thm_") or not fn.endswith(".lean"):
            continue
        path = os.path.join(WS, "Theorems", fn)
        try:
            txt = open(path, encoding="utf-8", errors="ignore").read()
        except OSError:
            continue
        names = [m.group(1) for m in DECL.finditer(txt)]
        if ident in names:
            hits.append((0, fn, path))
        elif any(n == tail or n.endswith("." + tail) for n in names):
            hits.append((1, fn, path))
    hits.sort()
    for _rank, fn, path in hits:
        slug = fn[4:-5]
        if (items.get("thm:" + slug, {}).get("status") == "done"
                and items.get("sol:" + slug, {}).get("status") == "done"):
            return "Theorems." + fn[:-5], path
    return None, None


def compile_bundle(lean, env, env_path, chapter):
    """(ok, first_error_line, next_lines) for Def_<chapter>."""
    path = os.path.join(WS, "Definitions", f"Def_{chapter}.lean")
    scratch = tempfile.mkdtemp(prefix="defloop-")
    try:
        cdl.link_mirror_oleans(scratch)
        e = dict(os.environ)
        e["LEAN_PATH"] = scratch + ":" + env_path
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
            cdl.compile_one(lean, e, scratch, stub, "Theorems")
        dst = os.path.join(scratch, "Definitions", os.path.basename(path))
        shutil.copy2(path, dst)
        r = subprocess.run(
            [lean, "-DautoImplicit=false", "-o", dst[:-5] + ".olean", dst],
            cwd=scratch, env=e, capture_output=True, text=True, timeout=900)
        out = (r.stdout + r.stderr).strip().splitlines()
        idx = next((i for i, l in enumerate(out) if "error" in l), None)
        if r.returncode == 0:
            return True, None, []
        if idx is None:
            return False, "(no error line)", []
        return False, out[idx], out[idx + 1:idx + 5]
    finally:
        shutil.rmtree(scratch, ignore_errors=True)


def add_import(chapter, mod):
    path = os.path.join(WS, "Definitions", f"Def_{chapter}.lean")
    t = open(path, encoding="utf-8").read()
    if re.search(r"^" + re.escape(mod) + r"$", t, re.M):
        return False
    m = list(re.finditer(r"^import .+$", t, re.M))
    pos = m[-1].end() if m else 0
    t = t[:pos] + "\nimport " + mod + t[pos:]
    open(path, "w", encoding="utf-8").write(t)
    # the gate world reads the mirror copy
    shutil.copy(path, os.path.join(MIRROR, "Definitions", os.path.basename(path)))
    return True


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapter")
    ap.add_argument("--max", type=int, default=8)
    args = ap.parse_args()
    lean, env_path = cpo.lean_env()
    if not lean:
        print("could not read the Lean environment from `lake env`")
        return 2
    items = ledger()
    for step in range(1, args.max + 1):
        ok, err, more = compile_bundle(lean, None, env_path, args.chapter)
        print(f"[{step}] {'OK' if ok else 'FAIL'} {err or ''}")
        for l in more:
            print("      " + l)
        if ok:
            print("PUBLISHABLE")
            return 0
        m = re.search(r"Unknown identifier `([^`]+)`", err or "")
        if not m:
            print("HAND-REPAIR-NEEDED (not an unknown-identifier class)")
            return 1
        mod, _ = stub_for(m.group(1), items)
        if not mod:
            print(f"NO USABLE STUB for {m.group(1)} (missing, or thm/sol not done)")
            return 1
        if not add_import(args.chapter, mod):
            print(f"import already present but {m.group(1)} still unknown: {mod}")
            return 1
        print(f"      + import {mod}")
    print("MAX STEPS REACHED")
    return 1


if __name__ == "__main__":
    sys.exit(main())
