#!/usr/bin/env python3
"""Drive a def bundle to OK by fixing one unknown identifier at a time.

`regate_bundles.py` reports the FIRST error of a bundle; a bundle whose proof
cites a dozen cross-chapter stubs it forgot to import then needs a dozen manual
round-trips.  This script runs that loop: compile, read `Unknown identifier
`X``, find the `Theorems/Thm_*` stub that declares X, add the missing
`import` to the workspace bundle, stage + compile that stub, recompile.

Guards kept identical to regate_bundles (same compiler, `-DautoImplicit=false`,
`LEAN_PATH = {MIRROR}:{base}`, stamp = sha1 of the workspace file, FAIL text
stored in state/def_gate.json / state/thm_gate.json), so the verdicts are the
ones upload_pipeline.thm_gate_fresh/def_gate_fresh read.

It REFUSES (exit 4, no edit) when the only provider is a stub generated FROM
the same chapter -- that import is a cycle (def_import_cycle in the pipeline
would defer the bundle forever) and the proof has to be inlined instead, as
done for parcelField_symmetricOn in Def_ChapterNsOneBodyDGamma.

Usage:
  python3 debug/fix_unknown_chain.py ChapterEsaOneParticleDGamma [more...]
  CANDIDATE_MIRROR=$PWD/state/mirror python3 debug/fix_unknown_chain.py ...
"""
import json
import hashlib
import os
import re
import subprocess
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
MAX_ITERS = 40


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


BASE = lake('printf %s "$LEAN_PATH"')
LEAN = lake("command -v lean")
ENV = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])
TIMEOUT = int(os.environ.get("REGATE_TIMEOUT", "1800"))


def stamp_of(path):
    try:
        return hashlib.sha1(open(path, "rb").read()).hexdigest()[:16]
    except OSError:
        return None


def compile_one(kind, m):
    src = "Definitions" if kind == "D" else "Theorems"
    full = f"{MIRROR}/{src}/{m}.lean"
    if not os.path.exists(full):
        return "NOSRC", ""
    try:
        r = subprocess.run([LEAN, "-DautoImplicit=false", "-o", f"{src}/{m}.olean",
                            f"{src}/{m}.lean"],
                           cwd=MIRROR, env=dict(ENV, LEAN_PATH=f"{MIRROR}:{BASE}"),
                           capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return "TIMEOUT", ""
    out = r.stdout + r.stderr
    if r.returncode == 0:
        return "OK", ""
    err = next((l for l in out.splitlines() if "error" in l), "")
    os.makedirs(f"{WS}/state/logs/fix_unknown", exist_ok=True)
    open(f"{WS}/state/logs/fix_unknown/{kind}_{m}.log", "w").write(out)
    return "FAIL " + err.strip().replace("\t", " ")[:300], out


def gate_write(path, key, status, stamp=None):
    """Merge one verdict in, keeping the record shape the pipeline reads
    (status + stamp == sha1 of the workspace file, the file_stamp check in
    def_gate_fresh/thm_gate_fresh)."""
    try:
        g = json.load(open(path))
        if not isinstance(g, dict):
            g = {}
    except (OSError, ValueError):
        g = {}
    g[key] = {"status": status, "stamp": stamp}
    json.dump(g, open(path, "w"), indent=1)


def stage_def(chapter):
    src = f"{WS}/Definitions/Def_{chapter}.lean"
    open(f"{MIRROR}/Definitions/Def_{chapter}.lean", "w").write(open(src).read())
    return src


def stage_stub(m):
    s = f"{WS}/Theorems/{m}.lean"
    if os.path.exists(s):
        open(f"{MIRROR}/Theorems/{m}.lean", "w").write(open(s).read())


def imports_of(path):
    try:
        t = open(path, encoding="utf-8", errors="ignore").read()
    except OSError:
        return []
    return re.findall(r"(?m)^\s*import Theorems\.(Thm_\S+)", t)


def find_provider(name):
    """Stub module declaring `name` (any namespace), or None."""
    pat = re.compile(r"(?m)^(?:theorem|lemma|def|noncomputable def|abbrev)\s+"
                     r"(?:[A-Za-z_][A-Za-z0-9_']*\.)*" + re.escape(name) + r"\b")
    hits = []
    for d in ("Theorems", "Definitions"):
        for fn in sorted(os.listdir(f"{WS}/{d}")):
            if not fn.endswith(".lean"):
                continue
            try:
                head = open(f"{WS}/{d}/{fn}", encoding="utf-8",
                            errors="ignore").read(200000)
            except OSError:
                continue
            if pat.search(head):
                hits.append((d, fn))
    return hits


def source_chapter_of_stub(stub_file):
    try:
        head = open(f"{WS}/Theorems/{stub_file}", encoding="utf-8").read(400)
    except OSError:
        return None
    m = re.match(r"-- Generated from (\S+) —", head)
    return m.group(1)[:-len(".lean")] if m else None


def add_import(path, stub_module):
    line = f"import Theorems.{stub_module}"
    txt = open(path, encoding="utf-8").read()
    if re.search(r"(?m)^" + re.escape(line) + r"$", txt):
        return True
    ms = list(re.finditer(r"(?m)^import Theorems\.\S+$", txt))
    if ms:
        pos = ms[-1].end()
        txt = txt[:pos] + "\n" + line + txt[pos:]
    else:  # before the first Definitions/Mathlib import keeps style order
        m2 = re.search(r"(?m)^import ", txt)
        pos = m2.start() if m2 else 0
        txt = txt[:pos] + line + "\n" + txt[pos:]
    open(path, "w").write(txt)
    return False


def process(chapter):
    print(f"--- {chapter}")
    for it in range(MAX_ITERS):
        src = stage_def(chapter)
        # wave 1: any thm stub the bundle imports that has no olean yet
        for m in sorted(set(imports_of(src))):
            if not os.path.exists(f"{MIRROR}/Theorems/{m}.olean"):
                stage_stub(m)
                st, _ = compile_one("T", m)
                gate_write(f"{WS}/state/thm_gate.json", m[len("Thm_"):], st,
                           stamp_of(f"{WS}/Theorems/{m}.lean"))
                print(f"    stub {m}: {st}")
                if not st == "OK":
                    return st
        st, out = compile_one("D", f"Def_{chapter}")
        gate_write(f"{WS}/state/def_gate.json", chapter, st, stamp_of(src))
        if st == "OK":
            print(f"    {chapter}: OK  ({it + 1} iterations)")
            return "OK"
        m = re.search(r"Unknown identifier `([^`]+)`", out or "")
        if m:
            name = m.group(1).split(".")[-1]
            provs = find_provider(name)
            stubs = [(d, f) for d, f in provs if d == "Theorems"]
            if not stubs:
                print(f"    no Thm_ stub declares `{name}` -- provider is "
                      f"{provs[:3] or 'nowhere'}; needs a manual fix")
                return st
            d, f = stubs[0]
            own = source_chapter_of_stub(f)
            if own == chapter:
                print(f"    CYCLE: the only stub for `{name}` is generated from "
                      f"this very chapter ({f}); inline the proof instead "
                      f"(see parcelField_symmetricOn)")
                return "CYCLE " + f
            mod = f[:-len(".lean")]
            existed = add_import(src, mod)
            stage_def(chapter)
            print(f"    + import Theorems.{mod} "
                  f"({name}; {'already there' if existed else 'added'})")
            continue
        m = re.search(r"object file '([^']+)' of module (\S+) does not exist", out or "")
        if m:
            mod = m.group(2)          # e.g. Definitions.Def_ChapterFoo
            dep = mod.split(".")[-1]
            if not dep.startswith("Def_"):
                print(f"    missing non-def module {mod}"); return st
            dep_ch = dep[len("Def_"):]
            print(f"    missing olean for {dep} -- compiling the dependency first")
            r = process(dep_ch)
            if r != "OK":
                return f"DEP {dep_ch}: {r}"
            continue
        print(f"    {st}")
        return st
    return "MAX_ITERS"


def main():
    if not os.path.isdir(MIRROR):
        print(f"no mirror at {MIRROR}")
        return 2
    rc = 0
    for ch in sys.argv[1:]:
        r = process(ch)
        if r != "OK":
            rc = 1
        print(f"==> {ch}: {r}")
    return rc


if __name__ == "__main__":
    sys.exit(main())
