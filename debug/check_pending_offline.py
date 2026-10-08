#!/usr/bin/env python3
"""Decide pending pipeline items offline, against the published mirror.

WHY
---
Every submission costs one of five attempts, and a broken file burns one per
visit until it is parked as `failed`. The uploader's local gate compiles each
file in *this* checkout, which is not the world the platform compiles in: 87 of
150 published bundles have drifted from their local file, so a local pass is not
evidence. `build_published_mirror.py` now elaborates all 155 published modules
using the platform's own text; this script uses that mirror as the oracle, so
"will this waste an attempt?" is answerable without spending one.

WHAT IT CHECKS
--------------
`thm:<name>`   the platform compiles `preamble + formal_statement` in the
               published world. So does this: `import Mathlib`, the
               Definitions import and opens that `upload_pipeline.IMPORT_DEF` /
               `OPENS` supply, then the statement extracted from
               `Theorems/Thm_<name>.lean`.

`sol:<name>`   the platform compiles `Solutions/Sol_<name>.lean` in the
               published world *plus the problem's own statement module*.
               A solution imports `Theorems.Thm_*` that is not published (that
               is what "pending" means), and Lean will not build a module from
               source during an import -- so phase 1 builds those statement
               modules against the mirror, and phase 2 compiles the solutions.

CLASSIFICATION
--------------
  ok             compiles clean
  FAIL:<err>     a Lean error; submitting would burn an attempt
  SKIP:<reason>  cannot judge here (no local file, no mirror, timeout)

A SKIP is not a pass. Only `ok` is evidence.

USAGE
-----
    PROVE2ME_WS=<ws> TIMEPIECE_PROJ=<timepiece331> \
      python3 debug/check_pending_offline.py --kind thm --jobs 4
    ... --kind sol
    ... --only <substring>
"""
import concurrent.futures as cf
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
PROJ = os.environ.get("TIMEPIECE_PROJ") or f"{WS}/../timepiece331"
MIRROR = "/tmp/published_mirror"
# Persistent root holding .oleans the mirror ships as source only: a published
# `Theorems.*` module without a mirror .olean made every item importing it fail
# with `object file ... does not exist` -- an oracle artifact, not a defect.
DEP_CACHE = "/tmp/thm_dep_olean"
OUT = f"{WS}/state/offline_pending_check.json"


def _link_mirror_oleans(target_dir):
    """Make `target_dir` a superset of the mirror's Theorems oleans.

    Lean's `findWithExt` resolves a module against the FIRST search-path entry
    where the package directory exists (`(p / pkg).isDir`), with no fallback to
    later roots -- so any scratch root that merely CONTAINS `Theorems/` captures
    every `Theorems.*` lookup, and a module absent from it dies with
    `object file ... does not exist` even though the mirror has its olean.  This
    bit run_sol (phase-1 scratch shadowed published oleans; 4 sibling solutions
    false-FAILED) and would have bitten DEP_CACHE the same way.  Symlinks keep
    the mirror the single source of truth; existing files (a phase-1 build) are
    never overwritten."""
    src = f"{MIRROR}/Theorems"
    if not os.path.isdir(src):
        return 0
    n = 0
    for ent in os.listdir(src):
        if not ent.endswith(".olean"):
            continue
        dst = os.path.join(target_dir, ent)
        if os.path.lexists(dst):
            continue
        try:
            os.symlink(os.path.join(src, ent), dst)
            n += 1
        except OSError:
            pass
    return n
SOL_DIR = f"{WS}/Solutions"
THM_DIR = f"{WS}/Theorems"

sys.path.insert(0, f"{WS}/pipeline")
import upload_pipeline as up  # noqa: E402

STATEMENT_IMPORT = re.compile(r"^\s*import Theorems\.(\S+)", re.M)


def lean_env():
    """The mirror first, then the published Lean/Mathlib search path.

    Order matters: a module in the mirror must win over the same module in this
    checkout, or the check would silently measure the drifted local copy again.
    """
    def sh(script):
        return subprocess.run(["lake", "env", "bash", "-c", script], cwd=PROJ,
                              capture_output=True, text=True).stdout.strip()
    base = sh('printf %s "$LEAN_PATH"')
    lean = sh("command -v lean")
    if not base or not lean:
        return None, None
    return lean, MIRROR + ":" + base


def first_error(out):
    lines = (out or "").split("\n")
    first = next((l.strip() for l in lines if "error" in l), None)
    # autoImplicit hides the real diagnosis: an unknown identifier in a binder
    # position surfaces as `Function expected at` / `type is not a class
    # instance`, and only the hint names the constant.  Without extracting it,
    # 156 distinct "Function expected at" records read like 156 unrelated shape
    # errors instead of the unknown-identifier class they are.
    m = re.search(r"The identifier `([^`]+)` is unknown", out or "")
    if m:
        loc = first.split("error", 1)[0].strip()[-60:] if first else ""
        return f"unknown identifier `{m.group(1)}` {loc}"[:200]
    if first:
        # Drop the scratch path before slicing: `/media/.../work/Chk_x.lean:`
        # eats ~140 of the 200 chars, so the identifier in
        # `Unknown identifier `bornWeight_eq_scoreSoftmax_neg_dist_sq``
        # arrived truncated (or entirely cut) and the fixer could not match it.
        short = re.sub(r"^.*?\.lean:", "L:", first)
        return short[:400]
    if out.strip():
        short = re.sub(r"^.*?\.lean:", "L:", out.strip().split("\n")[0])
        return short[:400]
    return "nonzero exit, no error line"


def compile_one(lean, env, src, workdir, olean=None):
    """Compile `src`; return (ok, first_error).

    `-DautoImplicit=false` is what the platform compiles with (Mathlib's
    setting), and without it this oracle LIES: a stub whose binder list omits a
    variable (`(Φ : CoreRep 84 D)` with no `D` in scope) auto-binds `D` here and
    reports `ok`, while the server answers `Unknown identifier `D`` and burns an
    attempt.  Reproduced head-to-head on
    BookProof.QuantumGravity3DGauge.qgMom_symmetricOn: ok by default, the
    platform's exact error with the flag.
    workdir: target directory for Lean's scratch output.
    olean:  when set, also emit the module's .olean there -- a plain
        `lean x.lean` only type-checks, so a module that later must be
        IMPORTED (run_sol's phase-1 statement modules) needs `-o` or the
        import fails with `object file ... does not exist`.
    """
    os.makedirs(workdir, exist_ok=True)
    cmd = [lean, "-DautoImplicit=false"]
    if olean:
        cmd += ["-o", olean]
    cmd += [src]
    r = subprocess.run(cmd, cwd=workdir, env=env,
                       capture_output=True, text=True, timeout=900)
    out = r.stdout + r.stderr
    if r.returncode == 0:
        return True, ""
    return False, first_error(out)


def pending(kind):
    st = json.load(open(f"{WS}/state/pipeline.json"))
    items = st["items"]
    out = []
    for key, rec in items.items():
        if not key.startswith(f"{kind}:"):
            continue
        if rec.get("status") != "pending":
            continue
        out.append(key.split(":", 1)[1])
    return sorted(out)


def formal_of(name):
    """Split a statement module exactly as the wave path does before submitting.

    The legacy path sends a fixed preamble (`import Mathlib` + Definitions import
    + OPENS). The wave path does not: it sends everything before the declaration
    -- the file's own imports, opens, `variables`, `omit ... in` -- as the
    preamble, and the declaration alone as `formal_statement`. That is what the
    platform compiles, so it is what has to be checked. Using the legacy
    preamble for a BookProof chapter reports ~121/129 statements as broken when
    they merely needed their own chapter's imports.

    Returns (preamble, formal, error)."""
    path = f"{THM_DIR}/Thm_{name}.lean"
    if not os.path.exists(path):
        return None, None, "no local Theorems/Thm_%s.lean" % name
    txt = open(path, encoding="utf-8").read()
    # Split at the first top-level `theorem`. Do NOT try to reconstruct the Lean
    # declaration name from the pipeline key: the key underscores chapter and
    # identifier alike (BookProof_ChapterH6_krylov_rayleigh_transfer), so
    # `replace("_", ".")` mangles the identifier into
    # BookProof.ChapterH6.krylov.rayleigh.transfer and the match fails. When that
    # happened this function fell through to the legacy fixed preamble and
    # reported 126 of 129 pending statements as broken when they were not.
    # Split at the FIRST top-level `theorem`, whatever it is named. Matching the
    # pipeline's slug does not work: the key underscores chapter and identifier
    # alike, so `BookProof_HermiteProductCore_hermiteCx_zero` cannot be
    # reconstructed from `BookProof.HermiteProductCore.hermiteCx_zero`. Getting
    # this wrong reported 10 statements as "cannot locate a declaration" when
    # they were perfectly fine.
    # Allow leading whitespace: a stub whose declarations sit inside a `namespace`
    # indents them, so anchoring at column 0 missed them and reported 10
    # perfectly good statements as "cannot locate a declaration".
    m = re.search(r"(?m)^[ \t]*theorem\s+\S", txt)
    if not m:
        return None, None, "cannot locate a declaration in Thm_%s.lean" % name
    preamble = txt[:m.start()].rstrip()
    formal = txt[m.start():].strip()
    return preamble, formal, ""


def _match(only, name):
    """`only` is None, a single substring, or a list of substrings (the CLI
    accepts a repeated --only); an item matches when any substring occurs in it."""
    if not only:
        return True
    if isinstance(only, str):
        return only in name
    return any(o in name for o in only)


def _published_thm_mods():
    """`Thm_*` module names the platform actually serves -- best effort.

    The mirror is NOT evidence of publication: build_published_mirror.py also
    stages local candidate sources (mirror_sources(pub, prefer_local=)), so
    Thm_..._projOp_apply_mem had a mirror .lean AND .olean while the server
    answered `unknown import ... No such theorem exists` and burned a real
    attempt (2026-10-07, 3 in one chunk).  Sources: publish jobs (authoritative)
    plus state's `done` records (covers an offline run).  None only when
    neither could be read, in which case publication is not guessed at."""
    mods, got = set(), False
    try:
        for p in up.published_theorems():
            mods.add("Thm_" + p.replace(".", "_"))
        got = True
    except Exception:
        pass
    try:
        items = json.load(open(f"{WS}/state/pipeline.json"))["items"]
        for k, v in items.items():
            if k.startswith("thm:") and v.get("status") == "done":
                slug = k.split(":", 1)[1]
                name = (getattr(up, "WAVE_THMS", {}).get(slug) or {}).get("name") \
                    or slug
                mods.add("Thm_" + name.replace(".", "_"))
        got = True
    except Exception:
        pass
    return mods if got else None


def _build_missing_deps(lean, env, pres, work, jobs):
    """Prepare .oleans for published `Theorems.*` modules the mirror carries
    as source only, so an item importing one can actually elaborate.

    Returns ({mod: build_error}, {unpublished_mod}).

    Source selection per module: publication is decided by the PLATFORM
    (publish jobs + state `done`), never by the mirror's contents -- a mirror
    .lean/.olean may be a locally staged candidate the server never saw.  A
    module the platform does not serve makes the importing item statically
    FAIL (`unknown import` server-side).  A published module without a mirror
    .olean is built from the mirror source (or the local stub when state says
    it is done) into DEP_CACHE, which persists across runs.  Returns
    ({mod: build_error}, {unpublished_mod})."""
    pub = _published_thm_mods()
    needed, unpub = {}, set()
    for pre in pres:
        for mod in re.findall(r"^\s*import\s+(Theorems\.\S+)", pre, re.M):
            if mod in needed or mod in unpub:
                continue
            base = mod.rpartition(".")[2]        # Thm_<slug>
            if pub is not None and base not in pub:
                unpub.add(mod)                   # server: no such theorem
                continue
            rel = mod.replace(".", "/")
            if os.path.exists(os.path.join(DEP_CACHE, rel) + ".olean") \
                    or os.path.exists(f"{MIRROR}/{rel}.olean"):
                continue                      # published and resolvable
            if os.path.exists(f"{MIRROR}/{rel}.lean"):
                needed[mod] = f"{MIRROR}/{rel}.lean"
            elif os.path.exists(f"{THM_DIR}/{base}.lean"):
                needed[mod] = f"{THM_DIR}/{base}.lean"
            elif pub is None:
                unpub.add(mod)                # unreadable everywhere
    res = {m: "" for m in unpub}
    if not needed:
        return {m: e for m, e in res.items() if e}, unpub
    os.makedirs(os.path.join(DEP_CACHE, "Theorems"), exist_ok=True)
    droot = os.path.join(work, "deps")
    os.makedirs(os.path.join(droot, "Theorems"), exist_ok=True)
    senv = dict(env)
    # Cache BEFORE the mirror: module resolution keeps the first root that has
    # the module at all, and the mirror has the .lean source -- so a cache entry
    # behind the mirror would be invisible and the object-file error returned.
    # The cache directory captures ALL `Theorems.*` lookups once it exists
    # (findWithExt keys on the package dir), so it must be a superset of the
    # mirror's oleans -- see _link_mirror_oleans.
    senv["LEAN_PATH"] = DEP_CACHE + ":" + env["LEAN_PATH"]
    os.makedirs(os.path.join(DEP_CACHE, "Theorems"), exist_ok=True)
    _link_mirror_oleans(os.path.join(DEP_CACHE, "Theorems"))

    def build(kv):
        mod, src = kv
        dst = os.path.join(droot, "Theorems", mod.rpartition(".")[2] + ".lean")
        shutil.copy2(src, dst)
        final = os.path.join(DEP_CACHE, *mod.split(".")) + ".olean"
        tmp = final + ".tmp"
        ok, err = compile_one(lean, senv, dst, droot, olean=tmp)
        if ok:
            os.replace(tmp, final)
            return mod, ""
        if os.path.exists(tmp):
            os.remove(tmp)
        return mod, err

    with cf.ThreadPoolExecutor(max_workers=max(1, min(jobs, 4))) as ex:
        for mod, err in ex.map(build, sorted(needed.items())):
            if err:
                res[mod] = err
    return {m: e for m, e in res.items() if e}, unpub


def run_thm(lean, env, names, only, jobs):
    work = tempfile.mkdtemp(prefix="offline-thm-")
    out = {}
    sel = [n for n in names if _match(only, n)]
    pres = []
    for n in sel:
        pre, _, _ = formal_of(n)
        if pre:
            pres.append(pre)
    dep_err, dep_unpub = _build_missing_deps(lean, env, pres, work, jobs)
    senv = dict(env)
    senv["LEAN_PATH"] = DEP_CACHE + ":" + env["LEAN_PATH"]
    # DEP_CACHE/Theorems, once it exists, captures every `Theorems.*` lookup
    # (findWithExt keys on the package dir) -- fill it with mirror oleans or
    # modules absent from the cache would die with `object file ... does not
    # exist` even though the mirror ships them.
    os.makedirs(os.path.join(DEP_CACHE, "Theorems"), exist_ok=True)
    _link_mirror_oleans(os.path.join(DEP_CACHE, "Theorems"))

    def one(name):
        if not _match(only, name):
            return None
        pre, formal, why = formal_of(name)
        if formal is None:
            return name, ("SKIP:" + why)
        # The mirror IS the platform's module world: a preamble that imports a
        # def bundle not staged here fails server-side with `unknown module
        # prefix` before elaboration even starts. Verdict it statically -- a
        # compile would cost a Mathlib import to reach the identical error.
        miss = [d for d in re.findall(r"^\s*import Definitions\.Def_(\S+)", pre, re.M)
                if not os.path.exists(os.path.join(MIRROR, "Definitions", f"Def_{d}.lean"))]
        if miss:
            return name, "FAIL:unpublished def import " + miss[0]
        for mod in re.findall(r"^\s*import\s+(Theorems\.\S+)", pre, re.M):
            if mod in dep_unpub:
                return name, "FAIL:unpublished sibling import " + mod
            if dep_err.get(mod):
                return name, f"FAIL:sibling build {mod}: {dep_err[mod]}"
        path = os.path.join(work, f"Chk_{abs(hash(name)) % 10**8}.lean")
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(pre + "\n\n" + formal + "\n")
        ok, err = compile_one(lean, senv, path, work)
        return name, ("ok" if ok else "FAIL:" + err)

    with cf.ThreadPoolExecutor(max_workers=jobs) as ex:
        for res in ex.map(one, sel):
            if res:
                out[res[0]] = res[1]
    shutil.rmtree(work, ignore_errors=True)
    return out


_DECL_RE = re.compile(
    r"(?m)^(?:@\[.*?\]\s*\n)*\s*(?:noncomputable\s+)?"
    r"(?:theorem|lemma|def|abbrev)\s+([^\s(:{]+)")


def _stub_declaring(mod):
    """Local stub whose DECLARATION flattens to `mod` (i.e. Thm_<decl>).

    File name alone is not reliable after the `_prime` rename wave: a slug
    keeps the source's apostrophe while the declaration was renamed
    (`Thm_X'.lean` declares `X_prime`), and an untracked twin
    `Thm_X_prime.lean` may hold the UN-renamed `X'`.  Choose by declaration
    so the module built under `mod` actually declares what the importing
    solution references.  Returns a path, or None when no local stub
    declares it."""
    stem = mod[len("Thm_"):] if mod.startswith("Thm_") else mod
    cands = [os.path.join(THM_DIR, mod + ".lean")]
    if stem.endswith("_prime"):
        cands.append(os.path.join(THM_DIR, "Thm_" + stem[:-6] + "'.lean"))
    if "_prime" in stem:
        cands.append(os.path.join(THM_DIR,
                                  "Thm_" + stem.replace("_prime", "'") + ".lean"))
    for c in dict.fromkeys(cands):
        if not os.path.exists(c):
            continue
        try:
            head = open(c, encoding="utf-8").read()
        except OSError:
            continue
        m = _DECL_RE.search(head)
        if m and m.group(1).replace(".", "_") == stem:
            return c
    # Fall back to the by-name file so behaviour is unchanged for every
    # module whose declaration regex does not fire.
    return cands[0] if os.path.exists(cands[0]) else None


def run_sol(lean, env, names, only, jobs):
    """Two phases: build the pending statement modules, then the solutions.

    Phase 1 output goes into a scratch `Theorems/` that is prepended to the
    search path, so `import Theorems.Thm_*` resolves for the solution without
    touching the mirror (which must keep reflecting only published modules)."""
    scratch = tempfile.mkdtemp(prefix="offline-sol-")
    thm_out = os.path.join(scratch, "Theorems")
    os.makedirs(thm_out, exist_ok=True)
    work = os.path.join(scratch, "work")
    os.makedirs(work, exist_ok=True)
    senv = dict(env)
    # LEAN_PATH roots map module `Theorems.Thm_X` to `<root>/Theorems/Thm_X`:
    # the root must be the scratch PARENT.  Pointing at the scratch Theorems/
    # directory itself made every phase-1 build invisible -- Lean fell through
    # to the mirror's source-only copy and failed with
    # `object file .../published_mirror/Theorems/Thm_X.olean does not exist`
    # even though the module had just been built successfully.
    senv["LEAN_PATH"] = scratch + ":" + senv["LEAN_PATH"]
    # ...and the converse: scratch/Theorems existing at all (os.makedirs below)
    # makes it the ONLY root Lean looks at for `Theorems.*`, so a transitive
    # import not built into phase 1 (e.g. via a def bundle) failed with
    # `object file .../offline-sol-.../Theorems/Thm_X.olean does not exist`
    # despite the mirror holding it.  Link the mirror's oleans in; phase-1
    # builds (os.path.lexists) are never overwritten.
    os.makedirs(thm_out, exist_ok=True)
    _link_mirror_oleans(thm_out)

    wanted = []
    for name in names:
        if not _match(only, name):
            continue
        path = f"{SOL_DIR}/Sol_{name}.lean"
        if not os.path.exists(path):
            continue
        for mod in STATEMENT_IMPORT.findall(open(path, encoding="utf-8").read()):
            if mod not in wanted:
                wanted.append(mod)

    built = {}

    def build(mod):
        # Local stubs are the source of truth: for a published sibling they are
        # exactly what we submitted (the mirror's Theorems/ snapshot is older
        # and still carries pre-transliteration names).  A missing local stub
        # means the sibling was never staged at all.  Resolution is by the
        # stub's DECLARATION (`_stub_declaring`), not by file name, so a
        # `_prime` import finds its apostrophe-named slug file.
        src = _stub_declaring(mod)
        if src is None:
            if os.path.exists(f"{MIRROR}/Theorems/{mod}.lean"):
                return mod, "FAIL:no local Theorems stub (sibling unpublished)"
            return mod, ("SKIP:no local Theorems/%s.lean" % mod)
        shutil.copy2(src, os.path.join(thm_out, f"{mod}.lean"))
        olean_p = os.path.join(thm_out, f"{mod}.olean")
        # A mirror-fill symlink may already sit here (this module is published).
        # `-o` would follow it and OVERWRITE THE MIRROR's olean with the local
        # stub's -- unlink so the write lands in the scratch instead.
        if os.path.islink(olean_p):
            os.remove(olean_p)
        # cwd must be the scratch root: Lean 4.33 rejects an input file that
        # is not contained in the cwd (`must be contained in root directory`),
        # and the input lives in <scratch>/Theorems/, not <scratch>/work/.
        ok, err = compile_one(lean, senv, os.path.join(thm_out, f"{mod}.lean"),
                              scratch, olean=olean_p)
        return mod, ("ok" if ok else "FAIL:" + err)

    with cf.ThreadPoolExecutor(max_workers=jobs) as ex:
        for mod, res in ex.map(build, wanted):
            built[mod] = res

    out = {}

    def one(name):
        if not _match(only, name):
            return None
        path = f"{SOL_DIR}/Sol_{name}.lean"
        if not os.path.exists(path):
            return name, "SKIP:no local Solutions/Sol_%s.lean" % name
        shutil.copy2(path, os.path.join(work, f"Chk_{abs(hash(name)) % 10**8}.lean"))
        ok, err = compile_one(lean, senv, os.path.join(work, f"Chk_{abs(hash(name)) % 10**8}.lean"), work)
        return name, ("ok" if ok else "FAIL:" + err)

    sel = [n for n in names if _match(only, n)]
    with cf.ThreadPoolExecutor(max_workers=jobs) as ex:
        for res in ex.map(one, sel):
            if res:
                out[res[0]] = res[1]
    shutil.rmtree(scratch, ignore_errors=True)
    return out, built


def summarise(res, label):
    ok = sum(1 for v in res.values() if v == "ok")
    fail = sum(1 for v in res.values() if v.startswith("FAIL:"))
    skip = sum(1 for v in res.values() if v.startswith("SKIP:"))
    print(f"\n=== {label}: {len(res)} item(s) ===")
    print(f"  ok   {ok}")
    print(f"  FAIL {fail}")
    print(f"  SKIP {skip}")
    return ok, fail, skip


def main():
    kinds = []
    for a in sys.argv[1:]:
        if a.startswith("--kind="):
            kinds.append(a.split("=", 1)[1])
    if "--kind" in sys.argv:
        kinds += sys.argv[sys.argv.index("--kind") + 1].split(",")
    if not kinds:
        kinds = ["thm", "sol"]
    # Repeated --only accumulates into a list (same contract as the uploader's
    # --only): a scoped run targets several items in one process.
    only = []
    pos = 0
    while True:
        try:
            i = sys.argv.index("--only", pos)
        except ValueError:
            break
        only.append(sys.argv[i + 1])
        pos = i + 2
    only = only or None
    # Re-run only the items currently marked `ok`: the autoImplicit defect made
    # some of those verdicts false positives, and a FAIL never becomes an ok by
    # re-running, so the FAILs (and SKIPs) are left untouched.
    recheck_ok = "--recheck-ok" in sys.argv
    jobs = 4
    if "--jobs" in sys.argv:
        jobs = int(sys.argv[sys.argv.index("--jobs") + 1])

    if not os.path.isdir(MIRROR):
        print(f"no published mirror at {MIRROR}; run debug/build_published_mirror.py first")
        return 2
    lean, env_path = lean_env()
    if not lean:
        print("could not read the Lean environment from `lake env`")
        return 2
    env = dict(os.environ)
    env["LEAN_PATH"] = env_path

    # Load and keep whatever kinds this run does NOT recompute: a later
    # `--kind sol` run must not erase fresh thm verdicts (the guard reads both
    # kinds from this one file), and the run's own kinds are replaced below.
    # After a regeneration both kinds must be re-run -- stale content from a
    # pre-regen run would otherwise ride on this file's newer mtime.
    try:
        merged = json.load(open(OUT))
        if not isinstance(merged, dict):
            merged = {}
    except (OSError, ValueError):
        merged = {}
    orig = json.loads(json.dumps(merged))  # snapshot: drives --recheck-ok below
    for k in kinds:
        merged.pop(k, None)

    allres = {}
    for kind in kinds:
        names = pending(kind)
        print(f"{kind}: {len(names)} pending", flush=True)
        prev = (orig.get(kind) or {}).get("items", {})
        if only:
            # A scoped run recomputes the matching items regardless of their
            # stored verdict (a renamed stub must re-verify even when its old
            # verdict was FAIL/SKIP), and the write path merges, so verdicts
            # outside the scope survive. --only alone is therefore safe.
            names = [n for n in names if _match(only, n)]
            print(f"{kind}: {len(names)} item(s) match --only", flush=True)
        elif recheck_ok:
            names = [n for n in names if prev.get(n) == "ok"]
            print(f"{kind}: rechecking {len(names)} item(s) marked ok", flush=True)
        if kind == "thm":
            res = run_thm(lean, env, names, only, jobs)
            built = {}
        else:
            res, built = run_sol(lean, env, names, only, jobs)
            bok = sum(1 for v in built.values() if v == "ok")
            bfail = len(built) - bok
            print(f"  statement modules needed: {len(built)} ({bok} built, {bfail} not)")
            for m, v in list(built.items()):
                if v != "ok":
                    print(f"    {v[:110]}  ({m})")
        summarise(res, kind)
        if recheck_ok or only:
            # Keep the verdicts we did not recompute instead of replacing the kind.
            items = dict((orig.get(kind) or {}).get("items", {}))
            items.update(res)
            stmt = dict((orig.get(kind) or {}).get("statement_modules", {}) or {})
            stmt.update(built)
        else:
            items, stmt = res, built
        allres[kind] = {"items": items, "statement_modules": stmt}
        # Incremental, and re-read at write time: a crash mid-sol must not lose
        # the thm verdicts, and a concurrent run that recomputed the OTHER kind
        # must not have its verdicts clobbered by this process's stale snapshot.
        # Write via rename so a reader (the submission guard) never sees a
        # half-written file.
        try:
            fresh = json.load(open(OUT))
            if not isinstance(fresh, dict):
                fresh = {}
        except (OSError, ValueError):
            fresh = {}
        fresh.update(allres)
        tmp = OUT + ".tmp"
        with open(tmp, "w") as fh:
            json.dump(fresh, fh, indent=1)
        os.replace(tmp, OUT)
        print(f"wrote {OUT} ({kind} verdicts in)", flush=True)

    print(f"\nwrote {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())