#!/usr/bin/env python3
"""Give a stub the `open` (and import) that a NAMESPACED provider name needs.

Measured on the 69-stub re-gate of 2026-11-05 (`state/logs/regate_thm2_1120.log`):
the dominant residual class is not a missing module but a missing `open`.
`Thm_BookProof_TensorSumEsa_pflow_neg` imports `Definitions.Def_ChapterFlowDGammaEsa`
-- which declares `structure OneParticleFlow` -- and still says
`Unknown identifier OneParticleFlow`, because the declaration sits inside
`namespace BookProof.FlowDGamma` and the stub only opens `TensorCore` /
`FarisLavine` / `GraphCore`.  `debug/find_missing_opens.py` diagnoses this shape
for `Solutions/`; this is the same repair for `Theorems/`, driven by the
compiler's own error rather than by a corpus-wide name sweep (5d's rule).

Per file: compile, read every `Unknown identifier X`, look X up in the mirror's
declarations, and
  * import the declaring module when the stub does not import it,
  * append `open <owning namespace>` for the exact namespace that declares X
    (`open A` does not expose a name declared in `A.B`).
Then recompile and only report OK for a compile that actually passed.

Usage:
  python3 debug/fix_unknown_ns.py <slug> [<slug> ...] [--jobs 8] [--dry-run]
  python3 debug/fix_unknown_ns.py --from-file state/scratch/x.txt
"""
import argparse
import concurrent.futures
import os
import re
import subprocess
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state/mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"

DECL = re.compile(
    r"^(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+|protected\s+|private\s+|scoped\s+)*"
    r"(?:def|theorem|lemma|abbrev|structure|class|inductive|opaque|instance)\s+"
    r"([^\s:({⟨\[]+)")
NS = re.compile(r"^namespace\s+(\S+)\s*$")
OPEN_TAG = re.compile(r"^section\s*(\S*)\s*$")
END = re.compile(r"^end(\s+\S+)?\s*$")
COMMENT = re.compile(r"/-.*?-/|--[^\n]*", re.S)


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def index():
    """bare name -> {(namespace, module)} over the mirror's declarations."""
    idx = {}
    for sub, prefix in (("Definitions", "Definitions"), ("Theorems", "Theorems")):
        d = os.path.join(MIRROR, sub)
        if not os.path.isdir(d):
            continue
        for fn in os.listdir(d):
            if not fn.endswith(".lean"):
                continue
            mod = f"{prefix}.{fn[:-5]}"
            stack = []
            for line in open(os.path.join(d, fn), encoding="utf-8",
                             errors="ignore"):
                line = line.split("--")[0].rstrip()
                m = NS.match(line)
                if m:
                    stack.append(("ns", m.group(1)))
                    continue
                if OPEN_TAG.match(line):
                    stack.append(("sec", None))
                    continue
                if END.match(line):
                    if stack:
                        stack.pop()
                    continue
                m = DECL.match(line)
                if not m:
                    continue
                parts = [n for k, n in stack if k == "ns"]
                bare = m.group(1).split(".")[-1]
                ns = ".".join(parts + [m.group(1).rpartition(".")[0]]
                              ).strip(".")
                idx.setdefault(bare, set()).add((ns, mod))
    return idx


def compile_out(path, env, lean, base):
    r = subprocess.run([lean, "-DautoImplicit=false", path],
                       env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                       capture_output=True, text=True, timeout=1800)
    return r.returncode, r.stdout + r.stderr


def unknown_names(out):
    names = re.findall(r"Unknown identifier [`\u2018']?([A-Za-z_][\w.']*)", out)
    names += re.findall(r"Function expected at\s*\n\s*([A-Za-z_][\w.']*)", out)
    names += re.findall(r"Unknown constant [`\u2018']?([A-Za-z_][\w.']*)", out)
    seen, out_names = set(), []
    for n in names:
        if n not in seen:
            seen.add(n)
            out_names.append(n)
    return out_names


def plan(text, names, idx):
    """(imports to add, namespaces to open) for the reported names."""
    imports = {m.group(1) for m in re.finditer(r"(?m)^import\s+(\S+)", text)}
    opened = {m.group(1) for m in re.finditer(r"(?m)^open\s+([A-Za-z0-9_. ]+)\s*$",
                                              text)}
    opened = {o.strip() for o in opened}
    add_mods, add_ns = [], []
    for n in names:
        cands = idx.get(n.split(".")[-1])
        if not cands:
            continue
        # Prefer a provider the stub already imports; otherwise take the single
        # unambiguous provider and import it too.
        here = sorted(c for c in cands if c[1] in imports)
        pick = here[0] if here else (sorted(cands)[0] if len(cands) == 1 else None)
        if pick is None:
            continue
        ns, mod = pick
        if ns and ns not in opened:
            if ns not in add_ns:
                add_ns.append(ns)
        if mod not in imports and mod not in add_mods:
            add_mods.append(mod)
    return add_mods, add_ns


def patch(path, mods, nss, dry):
    lines = open(path, encoding="utf-8").read().split("\n")
    adds = [f"import {m}" for m in mods] + [f"open {n}" for n in nss]
    if dry:
        return adds
    idx = [i for i, l in enumerate(lines) if l.startswith("import ")]
    at = max(idx) if idx else -1
    lines[at + 1:at + 1] = adds
    open(path, "w", encoding="utf-8").write("\n".join(lines))
    return adds


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file")
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args(argv)

    slugs = list(a.slugs)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    if not slugs:
        ap.error("no slugs")

    idx = index()
    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])

    def work(slug):
        slug = slug[4:] if slug.startswith("Thm_") else slug
        if not slug.startswith("BookProof_"):
            slug = "BookProof_" + slug
        path = f"{WS}/Theorems/Thm_{slug}.lean"
        if not os.path.exists(path):
            return slug, "MISSING", [], ""
        rc, out = compile_out(path, env, lean, base)
        if rc == 0:
            return slug, "OK-ALREADY", [], ""
        names = unknown_names(out)
        if not names:
            first = next((l for l in out.splitlines() if "error" in l), "")
            return slug, "OTHER", [], first.strip()[:120]
        mods, nss = plan(open(path, encoding="utf-8").read(), names, idx)
        if not mods and not nss:
            return slug, "UNRESOLVED", names, ""
        patch(path, mods, nss, a.dry_run)
        if a.dry_run:
            return slug, "WOULD-FIX", mods + nss, ""
        rc2, out2 = compile_out(path, env, lean, base)
        if rc2 == 0:
            return slug, "FIXED-OK", mods + nss, ""
        first = next((l for l in out2.splitlines() if "error" in l), "")
        return slug, "FIXED-STILL-FAIL", mods + nss, first.strip()[:120]

    with concurrent.futures.ThreadPoolExecutor(max_workers=max(1, a.jobs)) as ex:
        rows = list(ex.map(work, slugs))

    tally = {}
    for slug, status, adds, err in rows:
        tally[status] = tally.get(status, 0) + 1
        tail = (" + " + ", ".join(adds)) if adds else ""
        print(f"{status:17s} {slug[:52]}{tail}" + (f"  :: {err}" if err else ""))
    print(" ".join(f"{k}={v}" for k, v in sorted(tally.items())))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
