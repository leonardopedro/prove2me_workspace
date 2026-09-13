#!/usr/bin/env python3
"""Repair HOLLOW def bundles -- bundles whose declarations are bare headers.

THE DEFECT
----------
15 `Definitions/Def_*.lean` files declare their defs as

    def fqAmp

    def fqMl

with **no body at all** (and, for `Def_ChapterFullQuadraticEsa`, under a
namespace that does not exist in the source either -- the real namespace is
`BookProof.FullQuadratic`).  The platform rejects them with
`unexpected token 'def'`, and every thm/sol node of the chapter is starved.

12 of the 15 are wave-spec defs, so this class -- not "three special
chapters" -- is what the def layer is actually blocked on.

THE FIX
-------
Regenerate each hollow bundle with the sanctioned generator
(`scripts/wave_generate.py --defs-only <leaf>`, which needs `$TIMEPIECE_PROJ`
and `$PROVE2ME_WS`), then resolve the regenerated body's free identifiers the
way the platform requires: every namespace a bundle `open`s must be declared by
a module the bundle imports *directly* (PIPELINE_PLAN 1e), so each referenced
declaration that lives in another *published* `Def_*` bundle gets its
`import Definitions.Def_<chapter>` added.  Imports of bundles the platform does
not have yet are dropped (they would fail server-side) and reported instead.

Nothing is written without `--apply`, and every overwritten bundle is backed up
to `Definitions/Def_<leaf>.lean.pre_hollow.bak`.

USAGE
-----
    python3 debug/repair_hollow_defs.py --check              # report only
    python3 debug/repair_hollow_defs.py --dry-run            # regen + resolve, no write
    python3 debug/repair_hollow_defs.py --apply [ChapterX ...]
"""
import json
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = (os.environ.get("PROVE2ME_WS")
      or os.path.dirname(HERE)
      or "/home/leo/prove2me_workspace")
PROJ = (os.environ.get("TIMEPIECE_PROJ")
        or os.environ.get("PROVE2ME_PROJ")
        or "/home/leo/Projects/timepiece")
DEF_DIR = f"{WS}/Definitions"
SCRATCH = os.environ.get("HOLLOW_SCRATCH") or "/tmp/hollow_regen"

# a declaration keyword followed by a bare name and nothing else
BARE = re.compile(r"(?m)^\s*(?:noncomputable\s+|protected\s+|private\s+)?"
                  r"(?:def|abbrev|structure|inductive|class|theorem|lemma|instance)\s+"
                  r"([A-Za-z_][A-Za-z0-9_']*)\s*$")
DECL = re.compile(r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
                  r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance|notation)\s+"
                  r"([A-Za-z_][A-Za-z0-9_'.]*)")
NS = re.compile(r"(?m)^namespace\s+(\S+)")
TOKEN = re.compile(r"\b([a-zA-Z_][A-Za-z0-9_']*)\b")
IMPORT = re.compile(r"(?m)^import\s+Definitions\.Def_(\S+)")

STOP = {
    "import", "namespace", "end", "variable", "theorem", "def", "abbrev", "structure",
    "inductive", "class", "instance", "lemma", "noncomputable", "section", "open",
    "by", "fun", "let", "have", "show", "exact", "rw", "simp", "intro", "apply",
    "refine", "constructor", "simpa", "using", "where", "then", "else", "if", "match",
    "with", "deriving", "attribute", "scoped", "notation", "infix", "prefix", "postfix",
    "macro", "syntax", "elab", "termination_by", "decreasing_by", "Mathlib", "Prop",
    "Type", "Sort", "True", "False", "and", "or", "not", "iff", "forall", "exists",
    "Nat", "Int", "Real", "Complex", "Set", "Finset", "List", "Continuous", "Dense",
    "IsClosed", "Function", "Submodule", "LinearMap", "inner", "norm", "volume",
    "Measure", "MvPolynomial", "EuclideanSpace", "Fin", "Lp", "Memℓp",
}


def spec_state():
    spec = json.load(open(f"{WS}/pipeline/wave_upload.json"))
    try:
        st = json.load(open(f"{WS}/state/pipeline.json"))
        items = st.get("items", st)
    except Exception:
        items = {}
    return set(spec["defs"]), items


def bundle_index():
    """leaf-name -> (bundle, namespace) for every local Def_*.lean."""
    idx = {}
    for fn in sorted(os.listdir(DEF_DIR)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        bundle = fn[len("Def_"):-len(".lean")]
        txt = open(os.path.join(DEF_DIR, fn), encoding="utf-8", errors="replace").read()
        ns = NS.search(txt)
        for m in DECL.findall(txt):
            idx.setdefault(m.split(".")[0], (bundle, ns.group(1) if ns else "?"))
    return idx


def hollow(leaf):
    path = f"{DEF_DIR}/Def_{leaf}.lean"
    if not os.path.exists(path):
        return 0
    txt = open(path, encoding="utf-8", errors="replace").read()
    return len(BARE.findall(txt))


def regenerate(leaves):
    """Run the sanctioned generator into a scratch workspace."""
    os.makedirs(f"{SCRATCH}/Definitions", exist_ok=True)
    os.makedirs(f"{SCRATCH}/state", exist_ok=True)
    os.makedirs(f"{SCRATCH}/Theorems", exist_ok=True)
    os.makedirs(f"{SCRATCH}/Solutions", exist_ok=True)
    link = f"{SCRATCH}/state/sketch"
    if not os.path.exists(link):
        os.symlink(f"{WS}/state/sketch", link)
    env = dict(os.environ, PROVE2ME_WS=SCRATCH, TIMEPIECE_PROJ=PROJ)
    cmd = [sys.executable, f"{WS}/scripts/wave_generate.py", "--defs-only"] + leaves
    r = subprocess.run(cmd, env=env, capture_output=True, text=True)
    sys.stdout.write(r.stdout)
    sys.stderr.write(r.stderr)
    return r.returncode


def resolve(text, leaf, published, idx):
    """Imports for every external declaration the regenerated body references."""
    own = {m.split(".")[0] for m in DECL.findall(text)}
    used = {t for t in TOKEN.findall(text) if len(t) > 2 and t not in STOP}
    need = {}
    dropped = {}
    for name in sorted(used - own):
        hit = idx.get(name)
        if not hit:
            continue
        bundle, ns = hit
        if bundle == leaf:
            continue
        if bundle in published:
            need.setdefault(bundle, ns)
        else:
            names, ns0 = dropped.get(bundle, ({}, ns))
            names.setdefault(name, ns)
            dropped[bundle] = (names, ns0)
    return need, dropped


NSIDX = {}


def ns_index():
    """namespace -> bundle, for every `namespace X` declared by a local Def_*.lean."""
    out = {}
    for fn in sorted(os.listdir(DEF_DIR)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        bundle = fn[len("Def_"):-len(".lean")]
        txt = open(os.path.join(DEF_DIR, fn), encoding="utf-8", errors="replace").read()
        for m in NS.findall(txt):
            out.setdefault(m.rstrip(","), bundle)
    return out


def open_imports(text, leaf, published, nsidx):
    """Every `open BookProof.X` must be declared by a module the bundle imports
    DIRECTLY (PIPELINE_PLAN 1e), so an opened namespace whose declaring bundle
    is not imported has to pull that bundle in.  Returns (need, no_provider)."""
    need, missing = {}, set()
    for line in text.split("\n"):
        s = line.strip()
        if not (s.startswith("open ") or s.startswith("open scoped ")):
            continue
        body = s[len("open scoped "):] if s.startswith("open scoped ") else s[len("open "):]
        for tok in body.split():
            if not tok.startswith("BookProof"):
                continue
            best = None
            for ns in nsidx:
                if (tok == ns or tok.startswith(ns + ".")) and (best is None or len(ns) > len(best)):
                    best = ns
            if best is None:
                missing.add(tok)
            elif nsidx[best] != leaf and nsidx[best] in published:
                need[nsidx[best]] = best
            elif nsidx[best] != leaf:
                missing.add(tok)
    return need, missing


def insert_imports(text, bundles, idx):
    """Insert the `import Definitions.Def_X` lines after the leading import block."""
    existing = set(IMPORT.findall(text))
    add = [b for b in sorted(bundles) if b not in existing]
    if not add:
        return text, []
    lines = text.split("\n")
    at = 0
    for i, ln in enumerate(lines):
        if ln.startswith("import"):
            at = i + 1
    for b in reversed(add):
        lines.insert(at, f"import Definitions.Def_{b}")
    return "\n".join(lines), add


def main():
    args = sys.argv[1:]
    apply_ = "--apply" in args
    dry = "--dry-run" in args or apply_
    only = [a for a in args if not a.startswith("--")]

    spec, items = spec_state()
    # Platform ground truth: the module names of def publish jobs that reached
    # PUBLISHED (state/defs_published.json, written from GET /publish-jobs).
    # `state/pipeline.json` alone lags: --sync has to run to catch up.
    try:
        published = set(json.load(open(f"{WS}/state/defs_published.json")))
    except Exception:
        published = {d for d in spec if items.get("def:" + d, {}).get("status") == "done"}
        print("WARNING: state/defs_published.json missing -- using local state only")

    if only:
        leaves = list(only)          # explicit list: re-process even if no longer hollow
    else:
        leaves = sorted(f[len("Def_"):-len(".lean")] for f in os.listdir(DEF_DIR)
                        if f.startswith("Def_") and f.endswith(".lean")
                        and hollow(f[len("Def_"):-len(".lean")]))
    # A bundle repaired in this same batch counts as available: the runner's
    # preflight holds a submission back until every def bundle it imports is
    # published, and ORDER is deps-first, so the dependency lands first.
    published |= set(leaves)
    if not leaves:
        print("no hollow bundles")
        return 0
    print(f"hollow bundles: {len(leaves)}")
    for l in leaves:
        print(f"  {l}: {hollow(l)} bare header(s), in wave spec: {l in spec}, "
              f"platform has it: {l in published}")
    if not dry:
        return 0

    rc = regenerate(leaves)
    if rc != 0:
        print(f"generator exited {rc}")
    idx = bundle_index()
    global NSIDX
    NSIDX = ns_index()
    for leaf in leaves:
        src = f"{SCRATCH}/Definitions/Def_{leaf}.lean"
        if not os.path.exists(src):
            print(f"  {leaf}: NO OUTPUT from generator")
            continue
        text = open(src, encoding="utf-8").read()
        bare = BARE.findall(text)
        nsn = NS.search(text)
        need, dropped = resolve(text, leaf, published, idx)
        onames, missing = open_imports(text, leaf, published, NSIDX)
        for b, ns in onames.items():
            need.setdefault(b, ns)
        text2, added = insert_imports(text, need, idx)
        print(f"\n  {leaf}")
        print(f"    lines={len(text.splitlines())} namespace={nsn.group(1) if nsn else '?'} "
              f"bare_headers={len(bare)}")
        print(f"    imports added : {added or '(none)'}")
        for b, (names, ns) in sorted(dropped.items()):
            print(f"    NOT PUBLISHED : {b} <- {sorted(names)[:5]}  (import omitted)")
        if missing:
            print(f"    NO PROVIDER   : {sorted(missing)}  (namespace opened, no bundle declares it)")
        if apply_:
            dst = f"{DEF_DIR}/Def_{leaf}.lean"
            if os.path.exists(dst):
                bak = dst + ".pre_hollow.bak"
                if not os.path.exists(bak):
                    open(bak, "w", encoding="utf-8").write(
                        open(dst, encoding="utf-8").read())
            with open(dst, "w", encoding="utf-8") as f:
                f.write(text2)
            print(f"    WROTE {dst}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
