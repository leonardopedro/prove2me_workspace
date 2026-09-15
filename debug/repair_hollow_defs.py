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
    python3 debug/repair_hollow_defs.py --apply --faithful [ChapterX ...]
        # import-faithful: resolve imports only from `open` namespaces (exact)
        # and the generator's source-mapped Def imports -- never from body names
"""
import json
import os
import re
import shutil
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


def _components(ns):
    return ns.split(".")


def comp_alias(a, b):
    """`a` and `b` name the same namespace up to the generator's `Chapter`
    infix: `BookProof.CarlemanSimplex` vs `BookProof.ChapterCarlemanSimplex`.

    The generator names some bundles `BookProof.Chapter<Leaf>` where the source
    (and every consumer) says `BookProof.<Leaf>`, so an `open BookProof.X` has no
    provider even though the content was published.  Same arity, and every
    component equal or differing by exactly one `Chapter` prefix.
    """
    ca, cb = _components(a), _components(b)
    if len(ca) != len(cb):
        return False
    for x, y in zip(ca, cb):
        if x == y or x == "Chapter" + y or y == "Chapter" + x:
            continue
        return False
    return True


def load_platform_index():
    """state/defs_index.json (debug/platform_def_index.py): what the platform's
    PUBLISHED definition modules actually declare.  Authoritative -- the local
    Def_*.lean can be an empty placeholder for a live module."""
    try:
        return json.load(open(f"{WS}/state/defs_index.json", encoding="utf-8"))
    except Exception:
        return None


SRC_CACHE = {}


def source_decls(chapter):
    """Names declared by the SOURCE chapter `BookProof/Chapter<chapter>.lean`.

    Used to prove that dropping an `open` is safe: if none of the names the
    source declares in that namespace occur in the bundle body, the `open` was
    decorative (the generator copies the source's open list verbatim).
    """
    if chapter in SRC_CACHE:
        return SRC_CACHE[chapter]
    out = set()
    path = f"{PROJ}/BookProof/Chapter{chapter}.lean"
    if os.path.exists(path):
        txt = open(path, encoding="utf-8", errors="replace").read()
        out = {m.split(".")[0] for m in DECL.findall(txt)}
    SRC_CACHE[chapter] = out
    return out


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
    # Seed the scratch Definitions/ with the bundles that already exist.  The
    # generator emits `import Definitions.Def_X` only for providers it can SEE
    # (it tests os.path.exists against its own OUT_DEF), so an empty scratch
    # silently drops every source-faithful import and leaves the name-based
    # pass to invent a replacement -- that is where CoreFL's and DirectSumEsa's
    # mutual import came from.  Copies, never symlinks: the generator writes
    # into SCRATCH/Definitions, and a symlink would clobber the real bundle.
    for f in sorted(os.listdir(DEF_DIR)):
        if f.startswith("Def_") and f.endswith(".lean"):
            dst = f"{SCRATCH}/Definitions/{f}"
            if not os.path.exists(dst):
                shutil.copy2(f"{DEF_DIR}/{f}", dst)
    env = dict(os.environ, PROVE2ME_WS=SCRATCH, TIMEPIECE_PROJ=PROJ)
    cmd = [sys.executable, f"{WS}/scripts/wave_generate.py", "--defs-only"] + leaves
    r = subprocess.run(cmd, env=env, capture_output=True, text=True)
    sys.stdout.write(r.stdout)
    sys.stderr.write(r.stderr)
    return r.returncode


def resolve(text, leaf, published, idx, plat_leaf=None):
    """Imports for every external declaration the regenerated body references.

    The platform index (`state/defs_index.json`) wins over the local files: an
    identifier the server already publishes must be imported from the module
    that really declares it, even when the local Def_*.lean is a placeholder.
    """
    own = {m.split(".")[0] for m in DECL.findall(text)}
    used = {t for t in TOKEN.findall(text) if len(t) > 2 and t not in STOP}
    need = {}
    dropped = {}
    for name in sorted(used - own):
        hit = None
        pb = (plat_leaf or {}).get(name)
        if pb:
            hit = (pb, "?")
        if hit is None:
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
    """namespace -> bundle, for every `namespace X` declared by a local Def_*.lean.

    Nested blocks are COMPOSED: `namespace BookProof.NavierStokesFlow` followed by
    `namespace FullEsa` declares `BookProof.NavierStokesFlow.FullEsa`, which is the
    name a consumer's `open FullEsa` (or relative open) actually needs.  Recording
    only the raw tokens left that composite invisible, so no import was emitted and
    the server answered `unknown namespace FullEsa` -- a real submission spent on a
    gap in this index.  `section` pushes too, only so that its `end` pops the
    right frame; sections create no namespace prefix.
    """
    out = {}
    for fn in sorted(os.listdir(DEF_DIR)):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        bundle = fn[len("Def_"):-len(".lean")]
        txt = open(os.path.join(DEF_DIR, fn), encoding="utf-8", errors="replace").read()
        stack = []          # enclosing namespaces; "" marks a section frame
        for line in txt.split("\n"):
            s = line.strip()
            if s == "namespace" or s.startswith("namespace "):
                rel = s.split(None, 1)[1].strip().rstrip(",") if " " in s else ""
                if rel and stack and not rel.startswith("BookProof"):
                    enclosing = [x for x in stack if x][-1]
                    rel = enclosing + "." + rel
                stack.append(rel)
                if rel:
                    out.setdefault(rel, bundle)
            elif s == "section" or s.startswith("section "):
                stack.append("")
            elif s == "end" or s.startswith("end "):
                if stack:
                    stack.pop()
    return out


def qualify_opens(text, owners):
    """Rewrite relative `open X` tokens to the absolute name a provider owns.

    A source nested in `namespace BookProof.NavierStokesFlow` may say
    `open FullEsa`; Lean resolves that against the enclosing namespace prefixes,
    so the bundle needs the *import* of `BookProof.FullEsa`'s provider -- but the
    token carries no `BookProof` prefix for the resolver to key on, so the open
    was left alone and the server answered `unknown namespace FullEsa`.
    Deepest enclosing prefix first, then the bare name; anything unowned is left
    exactly as it was.
    """
    chain, out = [], []
    for line in text.split("\n"):
        s = line.strip()
        if s.startswith("namespace "):
            rel = s.split(None, 1)[1].strip().rstrip(",")
            if chain and not rel.startswith("BookProof"):
                rel = chain[-1] + "." + rel
            chain.append(rel)
        elif s == "end" or s.startswith("end "):
            if chain:
                chain.pop()
        if s.startswith("open ") or s.startswith("open scoped "):
            prefix = "open scoped " if s.startswith("open scoped ") else "open "
            toks = []
            for tok in s[len(prefix):].split():
                if tok.startswith("BookProof") or not tok[:1].isupper() or not chain:
                    toks.append(tok)
                    continue
                parts = chain[-1].split(".")
                cands = [".".join(parts[:i] + [tok]) for i in range(len(parts), 0, -1)]
                toks.append(next((c for c in cands if c in owners), tok))
            out.append(prefix + " ".join(toks))
        else:
            out.append(line)
    return "\n".join(out)


def open_imports(text, leaf, published, nsidx, plat=None, body_only=None):
    """Resolve every `open BookProof.X` the way the server will.

    A namespace must be declared by a module the bundle imports DIRECTLY
    (PIPELINE_PLAN 1e), so an opened namespace whose declaring bundle is not
    imported has to pull that bundle in.  Three outcomes per open:

    * `import Definitions.Def_<owner>` when a published bundle declares it;
    * **ALIASED** -- the generator's synthetic `BookProof.Chapter<Leaf>` name is
      rewritten to the name the source and the consumers use;
    * **DROPPED** -- nothing declares it and no declaration of the source chapter
      is used in the body (a decorative open copied from the source's header);
      reported as BLOCKING instead when the body does use one.

    Returns (need, no_provider, rewritten_text, aliased, dropped, blocking).
    """
    owners = {ns: b for ns, b in nsidx.items() if b != leaf}
    if plat:
        for ns, b in plat.get("namespace_owner", {}).items():
            if b != leaf:
                owners.setdefault(ns, b)
    # The file being replaced must not vouch for its own namespaces: the current
    # bundle may be a self-contained blob that declares them, while the
    # regenerated body this resolution is for does not.  Only what the
    # regenerated text itself declares counts as "own".
    for ns in NS.findall(text):
        owners[ns.rstrip(",")] = leaf
    # Relative opens do not carry a `BookProof` prefix; expand them first so the
    # resolver below sees the namespace the provider actually declares.
    text = qualify_opens(text, owners)
    need, missing = {}, set()
    aliased, dropped, blocking = {}, {}, set()
    out = []
    for line in text.split("\n"):
        s = line.strip()
        if not (s.startswith("open ") or s.startswith("open scoped ")):
            out.append(line)
            continue
        prefix = "open scoped " if s.startswith("open scoped ") else "open "
        kept = []
        for tok in s[len(prefix):].split():
            if not tok.startswith("BookProof"):
                kept.append(tok)
                continue
            best = None
            for ns in owners:
                if (tok == ns or tok.startswith(ns + ".")) and (best is None or len(ns) > len(best)):
                    best = ns
            newtok = tok
            if best is None:
                cands = [ns for ns in owners if comp_alias(tok, ns)]
                if cands:
                    best = max(cands, key=len)
                    newtok = best
                    aliased[tok] = best
            if best is None:
                # No provider under any spelling.  Safe to drop only if the body
                # never names anything that chapter declares.
                blob = body_only or text
                used = {n for n in source_decls(best_leaf_guess(tok))
                        if re.search(r"(?<![A-Za-z0-9_'])" + re.escape(n)
                                     + r"(?![A-Za-z0-9_'])", blob)}
                if used:
                    blocking.add(tok)
                    kept.append(tok)
                else:
                    dropped[tok] = "no provider; no name from it is used"
                continue
            owner = owners[best]
            if owner == leaf:
                kept.append(newtok)
            elif owner in published:
                need.setdefault(owner, best)
                kept.append(newtok)
            else:
                missing.add(newtok)
                kept.append(newtok)
        if kept:
            out.append(prefix + " ".join(kept))
    return need, missing, "\n".join(out), aliased, dropped, blocking


def best_leaf_guess(ns):
    """`BookProof.Book.ChapterFoo` -> `Foo`, for the source-declaration check."""
    leaf = ns.split(".")[-1]
    return leaf[len("Chapter"):] if leaf.startswith("Chapter") else leaf


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
    # `--faithful`: do NOT add imports derived from body *names*.  The name
    # index is keyed by leaf name, so common leaves (`ext`, `Lp`) resolve to a
    # bundle the source never imports -- that is how CoreFL and DirectSumEsa
    # acquired a mutual import and the def layer became unorderable.  The
    # faithful set is the namespace-based one (`open` resolution, which is
    # exact) plus the generator's source-mapped Def imports; the name-based
    # resolution is still reported, as a checker.
    faithful = "--faithful" in args
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
    # Platform ground truth (debug/platform_def_index.py).  A bundle whose newest
    # job FAILED may still be live from an earlier PUBLISHED run (PIPELINE_PLAN
    # 1e), so this widens the set rather than replacing it.
    plat = load_platform_index()
    if plat:
        plat_leaf = plat.get("name_owner") or None
        plat_pub = {b for b, v in plat.get("bundles", {}).items()
                    if v.get("status") == "PUBLISHED"}
        published |= plat_pub
        print(f"platform index: {len(plat_pub)} PUBLISHED bundle(s), "
              f"{len(plat_leaf or {})} declaration name(s)")
    else:
        plat_leaf = None
        print("WARNING: state/defs_index.json missing -- resolving from local files only")

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
        need, dropped = resolve(text, leaf, published, idx, plat_leaf)
        namebased = dict(need)
        if faithful:
            need = {}
        onames, missing, text_a, aliased, dropped_opens, blocking = open_imports(
            text, leaf, published, NSIDX, plat)
        for b, ns in onames.items():
            need.setdefault(b, ns)
        text2, added = insert_imports(text_a, need, idx)
        print(f"\n  {leaf}")
        print(f"    lines={len(text.splitlines())} namespace={nsn.group(1) if nsn else '?'} "
              f"bare_headers={len(bare)}")
        print(f"    imports added : {added or '(none)'}")
        if faithful and namebased:
            print(f"    NAME-BASED (ignored) : {sorted(namebased)}")
        for tok, ns in sorted(aliased.items()):
            print(f"    ALIASED OPEN  : {tok} -> {ns}")
        for tok, why in sorted(dropped_opens.items()):
            print(f"    DROPPED OPEN  : {tok} ({why})")
        if blocking:
            print(f"    BLOCKING OPEN : {sorted(blocking)}  (namespace has no provider and "
                  f"its declarations ARE used -- regenerate its bundle first)")
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
