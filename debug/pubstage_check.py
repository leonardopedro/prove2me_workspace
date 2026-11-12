"""Compile a def bundle in the environment the PLATFORM has, not the workspace has.

The platform holds *pruned* def modules: a published `Def_ChapterX` carries the
definitions only, while the lemmas next to them are published as `Thm_*` nodes
(or not at all).  The workspace def text still declares those lemmas, so a local
`lean` run against `state/mirror` accepts a bundle the platform rejects with
`Unknown identifier` -- measured on Def_ChapterEsaOneParticleDGamma, whose
`restrictOp_apply` is workspace-only: gate OK, platform FAIL (2 attempts spent).

This builds the platform's world instead: `state/pubstage` is a hardlink copy of
the candidate mirror with the *published* text of every direct
`import Definitions.Def_*` staged over it, those recompiled so their oleans match
published content, the `Thm_*` stubs the bundle imports built, and only then the
bundle itself.  A bundle that passes here has been checked against exactly what
the server will resolve.

Usage: python3 debug/pubstage_check.py Def_ChapterFoo [more...]
Import: check_one("Def_ChapterFoo", lean, base) -> (rc, first_error, bad_thms)
"""
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STAGE = os.path.join(WS, "state/pubstage")
MIRROR = os.path.join(WS, "state/mirror")
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))


def lean_cmd():
    env = dict(os.environ,
               PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:" + os.environ["PATH"])
    base = subprocess.run(["lake", "env", "bash", "-c", 'printf %s "$LEAN_PATH"'],
                          cwd=PROJ, capture_output=True, text=True).stdout.strip()
    lean = subprocess.run(["lake", "env", "bash", "-c", "command -v lean"],
                          cwd=PROJ, capture_output=True, text=True).stdout.strip()
    return env, base, lean


def compile_file(lean, path, lean_path, olean=None):
    """Lean writes no olean unless one is asked for explicitly (`-o`); the
    staging needs them or every consumer of a staged module fails on a missing
    object file."""
    cmd = [lean, "-DautoImplicit=false"]
    if olean:
        cmd += ["-o", olean]
    cmd.append(path)
    r = subprocess.run(cmd, env=dict(os.environ, LEAN_PATH=lean_path),
                       capture_output=True, text=True)
    return r.returncode, (r.stdout + r.stderr)


def ensure_stage():
    if not os.path.isdir(os.path.join(STAGE, "Definitions")):
        # A private copy of the candidate mirror is the root of the environment:
        # Lean resolves a module's imports under the root that owns the compiled
        # file, so staging a handful of files into an EMPTY dir makes every one
        # of their imports look for an olean that is not there.
        os.makedirs(STAGE, exist_ok=True)
        subprocess.run(["cp", "-al", os.path.join(MIRROR, "."), STAGE], check=False)


def build_all(lean, lean_path, todo, rounds=12):
    """Build a set of staged sources, retrying until their own staged imports
    are built.  Returns the sources that never built."""
    prev_fail = None
    for _ in range(rounds):
        again = []
        for dst in todo:
            rc, out = compile_file(lean, dst, lean_path, olean=dst[:-5] + ".olean")
            if rc != 0:
                again.append((dst, out))
        if not again:
            return []
        # A pass that still fails the SAME set made no progress: their own deps
        # cannot be built here (no published copy, or a content error).
        names = {dst for dst, _ in again}
        if prev_fail == names:
            return again
        prev_fail = names
        todo = [dst for dst, _ in again]
    return again


def check_one(ch, lean, lean_path, quiet=False):
    """(rc, first_error, unbuildable_thm_stubs) for one def bundle."""
    target = os.path.join(WS, "Definitions", f"{ch}.lean")
    txt = open(target, encoding="utf-8").read()
    deps = sorted(set(re.findall(r"^import\s+Definitions\.(Def_\w+)", txt, re.M)))
    # Transitive closure, because a helper the platform removed can be declared by
    # ANY def module the bundle reaches, not just a direct import: staging only the
    # direct ones left the mirror's rich copy of a deeper module in play, and the
    # check answered OK for a bundle the server then rejected (`crePoly_hermiteMvLp`).
    seen_deps, queue = set(), list(deps)
    while queue:
        dep = queue.pop()
        if dep in seen_deps:
            continue
        seen_deps.add(dep)
        p = os.path.join(WS, "state/published_bundles", f"{dep}.lean")
        if not os.path.exists(p):
            continue
        for nxt in re.findall(r"^import\s+Definitions\.(Def_\w+)", open(p, encoding="utf-8").read(), re.M):
            if nxt not in seen_deps:
                queue.append(nxt)
    deps = sorted(seen_deps)
    todo = []
    for dep in deps:
        pub = os.path.join(WS, "state/published_bundles", f"{dep}.lean")
        dst = os.path.join(STAGE, "Definitions", f"{dep}.lean")
        if not os.path.exists(pub):
            continue
        want = open(pub, encoding="utf-8").read()
        ol = dst[:-5] + ".olean"
        if not os.path.exists(dst) or open(dst, encoding="utf-8").read() != want:
            # pubstage is a hardlink farm off state/mirror: unlink before writing
            # or the staged text would overwrite the mirror's copy (same inode).
            if os.path.exists(dst):
                os.remove(dst)
            open(dst, "w", encoding="utf-8").write(want)
            if os.path.exists(ol):
                os.remove(ol)
        if not os.path.exists(ol) or os.path.getmtime(ol) < os.path.getmtime(dst):
            todo.append(dst)
    # Stage every published dep FIRST, then build them: a staged dep may import
    # another staged dep, so the compile order cannot be the staging order.
    for dst, out in build_all(lean, lean_path, todo):
        print(f"  STAGE-FAIL {os.path.basename(dst)[:-5]}: "
              f"{out.strip().splitlines()[:1]}")

    # The theorem nodes this bundle imports may never have been built (they are
    # stubs); their olean has to exist under the same root.
    thms = sorted(set(re.findall(r"^import\s+Theorems\.(Thm_\w+)", txt, re.M)))
    for t in thms:
        dst = os.path.join(STAGE, "Theorems", f"{t}.lean")
        if not os.path.exists(dst):
            src = os.path.join(WS, "Theorems", f"{t}.lean")
            if os.path.exists(src):
                open(dst, "w", encoding="utf-8").write(open(src, encoding="utf-8").read())
    todo = [os.path.join(STAGE, "Theorems", f"{t}.lean") for t in thms
            if os.path.exists(os.path.join(STAGE, "Theorems", f"{t}.lean"))
            and not os.path.exists(os.path.join(STAGE, "Theorems", f"{t}.olean"))]
    bad = [os.path.basename(dst)[:-5] for dst, _ in build_all(lean, lean_path, todo, rounds=3)]
    if not quiet:
        for t in bad:
            print(f"  THM-BUILD-FAIL {t}")

    rc, out = compile_file(lean, target, lean_path)
    err = next((l for l in out.splitlines() if "error" in l), "")
    return rc, err.strip(), bad


def main(argv):
    os.makedirs(STAGE, exist_ok=True)
    ensure_stage()
    env, base, lean = lean_cmd()
    lean_path = f"{STAGE}:{MIRROR}:{base}"
    bad_total = 0
    for ch in argv:
        rc, err, bad = check_one(ch, lean, lean_path)
        print(f"== {ch}: rc={rc}" + (f" (unbuilt thm stubs: {len(bad)})" if bad else ""))
        if err:
            print("   " + err[:220])
        bad_total += rc != 0
    return 1 if bad_total else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
