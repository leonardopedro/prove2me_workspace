#!/usr/bin/env python3
"""Compile `Theorems/*.lean` node stubs in the world the PLATFORM compiles them in.

The candidate mirror (`state/mirror`) stages this checkout's `Definitions/`
texts, which still carry every lemma that was published as a `Thm_*` node.
A stub for such a lemma then fails with

    `BookProof.PermSector.essentiallySelfAdjointOn_bosonic` has already been declared

which is the OPPOSITE of the platform's situation (the served bundle is pruned
of its lemmas, so the stub is the only declaration and the name must come from
the stub's own `Theorems.` imports).  So the mirror gate can neither confirm nor
refute a statement of this class, and `debug/gate_thm_ok.py` records a verdict
that says nothing about the submission.

This script builds the platform's world instead, reusing `pubstage_check`'s
stage: a hardlink copy of the candidate mirror with the *published* text of
every `Definitions.Def_*` module in the stub's transitive closure staged over
it, those recompiled, the stub's own `Theorems.` imports built (in that world
they compile), and only then the stub itself.

Usage:
  python3 debug/stub_served_check.py PermSector_essentiallySelfAdjointOn_bosonic_core ...
  python3 debug/stub_served_check.py --from-file state/scratch/stubs.txt
  # slugs may be bare, BookProof_<name> or Thm_BookProof_<name>

Exit status 0 iff every requested stub compiles.
"""
import argparse
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pubstage_check as PS  # noqa: E402

def stage_def(dep, seen, todo, closure=False):
    """Stage the published text of `dep` over the mirror copy.

    `closure=False` stages only the modules the stubs import *directly*: their
    own imports then resolve to the mirror's richer copies, which is the strict
    side of the question being asked ("does a name the pruned copy lacks resolve
    anyway?" -- if the answer is no with rich deps, it is no with pruned ones),
    and it keeps a full build to the dozen bundles that actually matter.  The
    full closure is 67 modules, ~3 h.
    """
    if dep in seen:
        return
    seen.add(dep)
    pub = os.path.join(PS.WS, "state/published_bundles", f"{dep}.lean")
    if not os.path.exists(pub):
        return
    text = open(pub, encoding="utf-8").read()
    dst = os.path.join(PS.STAGE, "Definitions", f"{dep}.lean")
    ol = dst[:-5] + ".olean"
    if (os.path.exists(dst) and os.path.exists(ol)
            and open(dst, encoding="utf-8").read() == text):
        return  # already staged AND built: do not throw the olean away
    if os.path.exists(dst):
        # the stage is a hardlink farm off state/mirror: unlink before writing
        os.remove(dst)
    open(dst, "w", encoding="utf-8").write(text)
    if os.path.exists(ol):
        os.remove(ol)
    todo.append(dst)
    if closure:
        for nxt in re.findall(r"^import\s+Definitions\.(Def_\w+)", text, re.M):
            stage_def(nxt, seen, todo, closure=True)


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file", default=None)
    ap.add_argument("--closure", action="store_true",
                    help="stage the whole transitive Definitions closure (67 "
                         "modules, ~3 h) instead of the stubs' direct imports")
    a = ap.parse_args(argv)
    slugs = list(a.slugs)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    mods = []
    for s in slugs:
        s = s.removeprefix("import ").removeprefix("Theorems.")
        s = s.removeprefix("Thm_").removeprefix("BookProof_")
        mods.append("Thm_BookProof_" + s)
    if not mods:
        print("no stubs requested")
        return 2
    os.makedirs(PS.STAGE, exist_ok=True)
    PS.ensure_stage()
    env, base, lean = PS.lean_cmd()
    lean_path = f"{PS.STAGE}:{PS.MIRROR}:{base}"

    todo, seen = [], set()
    for m in mods:
        src = os.path.join(PS.WS, "Theorems", m + ".lean")
        if not os.path.exists(src):
            print(f"  MISSING {m}")
            continue
        text = open(src, encoding="utf-8").read()
        for dep in re.findall(r"^import\s+Definitions\.(Def_\w+)", text, re.M):
            stage_def(dep, seen, todo, closure=a.closure)
    print(f"staged {len(todo)} published bundle(s)")
    for dst, out in PS.build_all(lean, lean_path, todo):
        print(f"  STAGE-FAIL {os.path.basename(dst)[:-5]}: "
              f"{out.strip().splitlines()[:1]}")

    # The stub's own `Theorems.` imports must exist and be built FIRST: in the
    # served world they are ordinary stubs (the sibling lemma is not in the
    # pruned def module), so they compile and leave an olean behind.
    thm_todo = []
    for m in mods:
        text = open(os.path.join(PS.WS, "Theorems", m + ".lean"), encoding="utf-8").read()
        for t in re.findall(r"^import\s+Theorems\.(Thm_\w+)", text, re.M):
            dst = os.path.join(PS.STAGE, "Theorems", t + ".lean")
            src = os.path.join(PS.WS, "Theorems", t + ".lean")
            if not os.path.exists(src):
                continue
            want = open(src, encoding="utf-8").read()
            if os.path.exists(dst) and open(dst, encoding="utf-8").read() == want:
                pass
            else:
                if os.path.exists(dst):
                    os.remove(dst)
                open(dst, "w", encoding="utf-8").write(want)
                ol = dst[:-5] + ".olean"
                if os.path.exists(ol):
                    os.remove(ol)
            if not os.path.exists(dst[:-5] + ".olean"):
                thm_todo.append(dst)
    print(f"staged {len(thm_todo)} theorem stub(s)")
    for dst, out in PS.build_all(lean, lean_path, thm_todo, rounds=4):
        print(f"  THM-STAGE-FAIL {os.path.basename(dst)[:-5]}: "
              f"{out.strip().splitlines()[:1]}")

    bad = 0
    for m in mods:
        src = os.path.join(PS.STAGE, "Theorems", m + ".lean")
        if not os.path.exists(src):
            print(f"  MISSING {m}")
            bad += 1
            continue
        rc, out = PS.compile_file(lean, src, lean_path)
        err = next((l for l in out.splitlines() if "error" in l), "")
        print(f"{'OK  ' if rc == 0 else 'FAIL'} {m[4:]}" + (f" :: {err.strip()[:200]}" if rc else ""))
        bad += rc != 0
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
