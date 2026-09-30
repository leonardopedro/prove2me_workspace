#!/usr/bin/env python3
"""Compile EVERY published def bundle, deps-first, and report all failures.

WHY THIS EXISTS
---------------
`def_mirror.py` answers "would this one bundle compile in the platform's
world?", and it stops at the first dependency that fails. That is right for
its question and useless for this one: the platform's world cannot be
reproduced at all until *all* the bundles the platform already holds
compile, because that world is the import path for every statement check.

And several do not. A published bundle was generated from a source snapshot;
this checkout has since moved (Lean 4.28 -> 4.33.1, chapter splits, a
regenerated declaration graph). Def_ChapterNavierStokesFullEsa declares its
symmetry lemmas in terms of `restrictCLM`, so it no longer elaborates here.
While that is true, a *statement* can only be checked by spending an attempt
on the platform -- 9 of which this repo spent on the ChapterH8 family, whose
members compile locally (our bundles still carry the `variable` they borrow)
and fail remotely (the published bundle does not).

So: one pass that compiles the whole published set, keeps going past every
failure, and prints them. Then repair the broken ones (regenerate from a
source project that builds) and re-run until the mirror builds. No API
calls, no upload attempts.

USAGE
-----
    PROVE2ME_WS=<ws> TIMEPIECE_PROJ=<lean project> \
      python3 debug/build_published_mirror.py
    python3 debug/build_published_mirror.py --reuse     # keep oleans
"""
import importlib.util
import json
import os
import re
import shutil
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
PROJ = os.environ.get("TIMEPIECE_PROJ") or os.environ.get("PROVE2ME_PROJ") or ""
MIRROR = os.environ.get("DEF_MIRROR") or "/tmp/published_mirror"

_dm = os.path.join(HERE, "def_mirror.py")
_spec = importlib.util.spec_from_file_location("def_mirror", _dm)
dm = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(dm)


def mirror_sources(pub):
    """Copy every published bundle into the mirror; withhold the rest, so an
    import of an unpublished bundle fails exactly as it does server-side.

    For a published bundle the authoritative text is what the platform holds,
    not the local `Definitions/` file: 87 of 150 published bundles have drifted,
    because `wave_generate.py` regenerated local copies that import modules the
    platform never imported. Building the local file measures this checkout;
    building the published text measures the platform. Sources, in order of
    preference, are `state/published_bundles/Def_<name>.lean` (cached verbatim
    from GET /publish-jobs) then the local file.

    Returns (kept, withheld, from_platform, from_local)."""
    d = os.path.join(MIRROR, "Definitions")
    cached = f"{WS}/state/published_bundles"
    os.makedirs(d, exist_ok=True)
    kept = withheld = from_platform = from_local = 0
    local_dir = os.path.join(WS, "Definitions")
    for f in sorted(os.listdir(local_dir)):
        if not (f.startswith("Def_") and f.endswith(".lean")):
            continue
        name = f[len("Def_"):-len(".lean")]
        if name not in pub:
            withheld += 1
            continue
        plat = os.path.join(cached, f)
        loc = os.path.join(local_dir, f)
        src = plat if os.path.exists(plat) else loc
        if src is plat:
            from_platform += 1
        else:
            from_local += 1
        dst = os.path.join(d, f)
        if not (os.path.exists(dst) and os.path.getmtime(dst) >= os.path.getmtime(src)):
            shutil.copy2(src, dst)
            for stale in (dst[:-5] + ".olean", dst[:-5] + ".ilean"):
                if os.path.exists(stale):
                    os.remove(stale)
        kept += 1
    # published bundles with no local file at all must still be built
    if os.path.isdir(cached):
        for f in sorted(os.listdir(cached)):
            if not (f.startswith("Def_") and f.endswith(".lean")):
                continue
            name = f[len("Def_"):-len(".lean")]
            if name not in pub:
                continue
            # The first pass already counted every bundle that has a local file.
            # This pass exists for published bundles with no local file at all, so
            # only those are new here -- otherwise `kept` double-counts them.
            if os.path.exists(os.path.join(local_dir, f)):
                continue
            dst = os.path.join(d, f)
            if not os.path.exists(dst):
                shutil.copy2(os.path.join(cached, f), dst)
            kept += 1
            from_platform += 1
    return kept, withheld, from_platform, from_local


def lake_env_sh(script):
    return subprocess.run(["lake", "env", "bash", "-c", script], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def order_all(pub):
    """Deps-first order over the published set. Cycles cannot happen: the
    import graph is a DAG (verified separately), but a cycle would silently
    drop nodes, so anything left over is appended rather than forgotten."""
    order, seen = [], set()

    def deps(n):
        # A published bundle can have no local source at all (its Def_ file was
        # never generated here); reading it would raise, so treat it as a leaf.
        path = os.path.join(MIRROR, "Definitions", f"Def_{n}.lean")
        if not os.path.exists(path):
            return []
        return dm.imports_of(path)

    def visit(n):
        if n in seen or n not in pub:
            return
        seen.add(n)
        for d in deps(n):
            visit(d)
        order.append(n)

    for start in sorted(pub):
        visit(start)
    return order


def declares_a_theorem(path):
    """Does this module actually declare something?

    The platform's published `Theorems.*` text for a theorem is a hollow
    skeleton: it exists only so a Definitions module has something to import,
    and the declaration is withheld until the theorem is Proved. Measured
    against that skeleton, `Def_ChapterQgHermiteFriedrichs` failed with
    `unknown identifier memLp_mul_pgFun_of_expBounded`. A local
    `Theorems/Thm_*.lean` declares the name (with `by sorry`), which is what a
    Definitions-layer import actually needs -- the name, not the proof.
    """
    if not os.path.exists(path):
        return False
    return bool(re.search(r"(?m)^\s*(?:theorem|lemma|axiom)\s+\S", open(path, errors="ignore").read()))


def mirror_theorems():
    """Copy the published `Theorems.*` modules that published def bundles import.

    Three published bundles import Theorems modules, and a Definitions-only
    mirror reports them as `unknown module prefix 'Theorems'` -- which reads
    like a platform defect but is only a scope gap here. Those modules are stubs
    whose content is not the point; their existence is, so the import resolves
    and the def bundle is measured on its own text."""
    cached = f"{WS}/state/published_theorems"
    local = f"{WS}/Theorems"
    d = os.path.join(MIRROR, "Theorems")
    if not os.path.isdir(cached):
        return [], 0
    os.makedirs(d, exist_ok=True)
    names, declaring = [], 0
    for f in sorted(os.listdir(cached)):
        if not (f.startswith("Thm_") and f.endswith(".lean")):
            continue
        src = os.path.join(cached, f)
        local_src = os.path.join(local, f)
        if declares_a_theorem(local_src):
            src = local_src
            declaring += 1
        dst = os.path.join(d, f)
        if not (os.path.exists(dst) and os.path.getmtime(dst) >= os.path.getmtime(src)):
            shutil.copy2(src, dst)
            for stale in (dst[:-5] + ".olean", dst[:-5] + ".ilean"):
                if os.path.exists(stale):
                    os.remove(stale)
        names.append(f[:-len(".lean")])
    return names, declaring


def order_theorems():
    """Deps-first order for the cached theorem modules, over the published set.

    A theorem stub imports `Mathlib` and possibly a `Definitions.Def_*` bundle, so
    it must come after the Definitions it imports."""
    cached = f"{WS}/state/published_theorems"
    if not os.path.isdir(cached):
        return []
    order, seen = [], set()

    def deps(mod):
        path = os.path.join(MIRROR, "Theorems", f"{mod}.lean")
        if not os.path.exists(path):
            return []
        return [l.split("Def_")[1].strip()
                for l in open(path, errors="ignore")
                if l.startswith("import Definitions.Def_")]

    def visit(mod):
        if mod in seen:
            return
        seen.add(mod)
        for d in deps(mod):
            visit_def(d)
        order.append(mod)

    def visit_def(name):
        if name in def_seen:
            return
        def_seen.add(name)
        path = os.path.join(MIRROR, "Definitions", f"Def_{name}.lean")
        if os.path.exists(path):
            for d in dm.imports_of(path):
                visit_def(d)

    def_seen = set()
    for f in sorted(os.listdir(cached)):
        if f.startswith("Thm_") and f.endswith(".lean"):
            visit(f[:-len(".lean")])
    return order


def order_interleave(ordered):
    """Topologically sort the mixed def/theorem graph.

    `order_all` only knows about `Definitions.Def_*`. A published def bundle can
    also `import Theorems.Thm_*`, so those edges exist too. Rather than bolting
    the theorem stubs on at the end (which would build three stubs before the
    bundles that need them), sort the union: a stub follows the Definitions it
    imports, and the bundles that import it follow the stub.

    Anything left over after the walk -- a genuine cycle, which cannot happen in
    a DAG but is not worth crashing over -- is appended rather than dropped.
    """
    nodes = {f"{k}:{n}" for k, n in ordered}
    order, seen = [], set()

    def imports(path):
        out = []
        if not os.path.exists(path):
            return out
        for line in open(path, errors="ignore"):
            m = re.match(r"import Definitions\.Def_(\S+)", line)
            if m:
                out.append(("def", m.group(1)))
                continue
            m = re.match(r"import Theorems\.(Thm_\S+)", line)
            if m:
                out.append(("thm", m.group(1)))
        return out

    def deps(kind, name):
        folder = "Definitions" if kind == "def" else "Theorems"
        prefix = "Def_" if kind == "def" else ""
        return [n for n in imports(os.path.join(MIRROR, folder, f"{prefix}{name}.lean"))
                if f"{n[0]}:{n[1]}" in nodes]

    def visit(kind, name):
        key = f"{kind}:{name}"
        if key in seen:
            return
        seen.add(key)
        for dk, dn in deps(kind, name):
            visit(dk, dn)
        order.append((kind, name))

    for kind, name in ordered:
        visit(kind, name)
    for kind, name in ordered:
        if f"{kind}:{name}" not in seen:
            order.append((kind, name))
    return order


def main():
    reuse = "--reuse" in sys.argv
    if not PROJ:
        print("set TIMEPIECE_PROJ to the Lean project that owns the toolchain")
        return 2
    pub = dm.published_set()
    if not reuse:
        shutil.rmtree(MIRROR, ignore_errors=True)
    kept, withheld, from_platform, from_local = mirror_sources(pub)
    print(f"mirror {MIRROR}: {kept} published bundle(s) present, {withheld} withheld "
          f"({from_platform} from the platform cache, {from_local} local)",
          flush=True)

    base_path = lake_env_sh('printf %s "$LEAN_PATH"')
    lean_bin = lake_env_sh('command -v lean')
    if not base_path or not lean_bin:
        print("could not read the Lean environment from `lake env` (is PROJ a Lean project?)")
        return 2
    env = dict(os.environ)
    env["LEAN_PATH"] = MIRROR + ":" + base_path

    thm_mods, thm_declaring = mirror_theorems()
    if thm_mods:
        print(f"mirror {MIRROR}: {len(thm_mods)} Theorems module(s) present "
              f"({thm_declaring} declare a theorem, the rest are platform skeletons)",
              flush=True)

    order = [("def", n) for n in order_all(pub)]
    order += [("thm", m) for m in order_theorems()]
    # interleave deps-first: a theorem stub must follow the Definitions it
    # imports, and the def bundles that import it must follow the stub.
    order = order_interleave(order)
    print(f"compiling {len(order)} module(s) deps-first", flush=True)

    ok, failed, skipped = 0, [], []
    for i, (kind, name) in enumerate(order, 1):
        src = os.path.join(MIRROR, "Definitions" if kind == "def" else "Theorems",
                           f"{'Def_' if kind == 'def' else ''}{name}.lean")
        olean = src[:-5] + ".olean"
        if os.path.exists(olean):
            skipped.append(name)
            ok += 1
            continue
        if not os.path.exists(src):
            failed.append((name, "source missing from the mirror"))
            continue
        t0 = time.time()
        r = subprocess.run([lean_bin, "-o", olean, src], cwd=MIRROR, env=env,
                           capture_output=True, text=True)
        if r.returncode == 0:
            ok += 1
            print(f"  [{i}/{len(order)}] ok  {name}  {time.time()-t0:.1f}s", flush=True)
        else:
            msg = (r.stdout + r.stderr).strip()
            first = next((l for l in msg.split("\n") if "error" in l), msg[:200])
            failed.append((name, first.strip()[:180]))
            print(f"  [{i}/{len(order)}] FAIL {name}", flush=True)

    print(f"\n=== SUMMARY ===")
    print(f"compiled {ok} ({len(skipped)} cached), {len(failed)} failed")
    for name, why in failed:
        print(f"  {name}: {why}")
    report = os.path.join(WS, "state", "published_mirror_failures.json")
    json.dump([{"leaf": n, "error": w} for n, w in failed], open(report, "w"), indent=1)
    print(f"wrote {report}")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())