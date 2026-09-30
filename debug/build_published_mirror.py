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
            if name not in pub or os.path.exists(os.path.join(d, f)):
                continue
            shutil.copy2(os.path.join(cached, f), os.path.join(d, f))
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

    order = order_all(pub)
    print(f"compiling {len(order)} bundle(s) deps-first", flush=True)

    ok, failed, skipped = 0, [], []
    for i, name in enumerate(order, 1):
        src = os.path.join(MIRROR, "Definitions", f"Def_{name}.lean")
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