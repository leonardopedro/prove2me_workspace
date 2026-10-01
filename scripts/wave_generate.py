#!/usr/bin/env python3
"""Phase 2-4 generator for timepiece wave modules (Mathlib-only BookProof
chapters that compile verbatim in the platform env v4.33.1 / Mathlib 0df444a).

Produces, per participating module:
  Definitions/Def_<leaf>.lean          def-material bundle: non-private
                                       def/abbrev/structure/class/inductive/
                                       instance decls (source spans) + any
                                       def-embedded theorem (cited by an
                                       included def body), in source order.
  Theorems/Thm_<fullname-dots->underscores>.lean
                                       per node theorem: structural preamble
                                       (imports + opens + variables) then
                                       `theorem <Fully.Dotted.Name> ... := by sorry`
  Solutions/Sol_<fullname-...>.lean    per node theorem: preamble + inline
                                       helper pastes + `open <Ns> in`
                                       `set_option maxHeartbeats 1000000 in`
                                       `theorem solution ... := by <proof>`

All offsets from Stage 2 are BYTE offsets into the source file; Python str
slicing is code-point based, so every byte offset is converted via a prefix
byte-length table before slicing.  Preambles contain ONLY structural lines
(import / open / open scoped / variable / include / set_option /
noncomputable section), never module docs, namespace/section lines, or other
declaration bodies — the namespace is restored by `open <Ns>` (Thm) and
`open <Ns> in` (Sol), per playbook Phase 4.

Classification (playbook Phase 2): node = public theorem with proof > 40
lines, or 11-40 lines with a promotion signal (docstring present, cited by
>=2 node proofs, or named in the module docstring); otherwise inline.
Def-material = non-private defs/inductives + instance roots.  Def-embedded
theorems (cited by a def body) stay in the bundle so it never imports a
sorry stub.
"""
import glob
import json
import os
import re
import subprocess
import sys

# Host paths.  Defaults are the canonical build host; both are overridable so
# the generator also runs from a sandbox checkout (e.g. the Freebuff cloud
# workspace) that has its own copy of the workspace and of the source project.
#   PROVE2ME_WS     -> workspace root (Definitions/Theorems/Solutions/spec)
#   TIMEPIECE_PROJ  -> source project root (decl_graph.jsonl + BookProof/*.lean)
WS = os.environ.get("PROVE2ME_WS") or "/home/leo/prove2me_workspace"
PROJ = (os.environ.get("TIMEPIECE_PROJ")
        or os.environ.get("PROVE2ME_PROJ")
        or "/home/leo/Projects/timepiece")
GRAPH = f"{PROJ}/decl_graph.jsonl"
SKETCH_DIR = f"{WS}/state/sketch"
OUT_DEF = f"{WS}/Definitions"
OUT_THM = f"{WS}/Theorems"
OUT_SOL = f"{WS}/Solutions"

WAVE = [
    # Transitive dependencies (must come before modules that use them)
    "ChapterHermiteFunctions",       # used by ChapterHermiteProductCore, ChapterYangMillsHermite
    "ChapterHermiteProductCore",    # provides gaussInt, L2d
    "ChapterH1",                    # used by ChapterH4
    "ChapterH4",                    # provides numRange, used by SirkWhitening/EndToEnd/DiffusiveDecay
    # Faris-Lavine chain (used by HashimotoShiftInvert, EsaClosure, NavierStokes*, Sirk*)
    "ChapterFarisLavineCore",       # provides BookProof.FarisLavine namespace
    "ChapterHashimotoComplexShifts", # provides BookProof.HashimotoShiftInvert namespace
    "ChapterEsaClosure",             # provides BookProof.EsaClosure namespace
    # Main wave
    "ChapterBaryonAsymmetry", "ChapterMajoranaClifford",
    "ChapterMajoranaProp61", "ChapterMajoranaProp76",
    "ChapterParityMajoranaQuant", "ChapterYangMillsBianchi",
    "ChapterYangMillsSU3", "ChapterSirkGroupTransfer",
    # Wave 2: QYM/SIRK/ESA expansion (selected self-contained chapters)
    "ChapterYangMillsGhostSector", "ChapterYangMillsHermite",
    "ChapterSirkBandLedger", "ChapterSirkCertifiedGap",
    "ChapterSirkRitzMinMax", "ChapterHermiteBandCalculus",
    # Additional chapters needed by the current def bundles
    "ChapterNavierStokesThreeComponent", "ChapterNavierStokesDiffHashimoto",
    "ChapterNavierStokesLagrangianCanonical", "ChapterStarobinskyPotential",
    "ChapterStoneBridge", "ChapterQgHermiteOscillatorEsa", "ChapterYangMillsFriedrichs",
    "ChapterHermiteGalerkinFriedrichs", "ChapterHermiteProductBasis", "ChapterHermiteRelativeBound",
    # QG mode instances and outer Fock (dependency chain for QgOuterFockEsa)
    "ChapterScalaronCoreEsa", "ChapterScalaronWallEsa", "ChapterScalaronFiberFL", "ChapterSchrodingerCutoffEsa",
    "ChapterQgOuterFockFlow", "ChapterQuantumGravity3DGauge",
    "ChapterQgOuterFockEsa", "ChapterQg3DGaugeEsa",
    "ChapterQgOuterFockCoreFL", "ChapterQgOuterFockFarisLavine",
    "ChapterQgHermiteCore", "ChapterQgHermiteFriedrichs",
    "ChapterQgVielbeinModeInstance", "ChapterQgContinuumModeInstance",
    "ChapterQgTruncationResolvent", "ChapterQgTimeStepping",
    "ChapterQgManifoldModeInstance", "ChapterQgTimeIndependentFlow",
    "ChapterQymTimeIndependentFlow", "ChapterYangMillsAbelianFockEsa",
    "ChapterYangMillsAbelianEsa", "ChapterYangMillsBandBounds",
    "ChapterScalaronOuterFockFL", "ChapterFiniteSectionSingleTime",
    "ChapterSirkSingleTimeShift", "ChapterGaussCoreQuadBounds",
    "ChapterSqSumFarisLavine", "ChapterWallEsaSemibounded",
    "ChapterBddBelowFiberSumEsa", "ChapterQgBrstDerivativeGauge",
    "ChapterQgCouplingDGammaSum", "ChapterModeQuadraticEsa",
    "ChapterFullQuadraticEsa", "ChapterQuadraticFockEsa",
    "ChapterNavierStokesFockSpace", "ChapterNavierStokesFockCanonical",
    "ChapterNavierStokesFockFarisLavine", "ChapterNavierStokesFockContinuum",
    "ChapterNavierStokesFockManyMode", "ChapterGhostField",
    "ChapterCarlemanSimplex", "ChapterCarlemanTwoStep",
    # Remaining chapters
    "ChapterNavierStokesFlow", "ChapterDoubleSlit", "ChapterFreeFieldConstraint",
    "ChapterComplexShiftCore", "ChapterContinuityUnitary", "ChapterContinuityUnitaryInfinite",
    "ChapterEsaClosureCore", "ChapterStoneResolvent", "ChapterNavierStokesCauchy",
    "ChapterNavierStokesEsa", "ChapterStoneGroup", "ChapterNavierStokesDeficiency",
    "ChapterNavierStokesFullEsa", "ChapterStoneEvolution", "ChapterStoneUnitary",
    "ChapterFarisLavine", "ChapterKatoRellichDeficiency", "ChapterKatoRellichRelative",
    "ChapterNavierStokesIkebeKato", "ChapterNavierStokesShiftHamiltonian",
    "ChapterQuantumGravityDensitized", "ChapterStoneGenerator", "ChapterStoneMeasurable",
    "ChapterStrichartzWave", "ChapterWaveBoundedPotential",
    "ChapterYangMillsFriedrichsLimit", "ChapterNavierStokesHermiteFarisLavine",
    "ChapterStoneConverse", "ChapterStoneTheorem", "ChapterHashimotoShiftInvert",
    "ChapterNavierStokesAffineFiberEsa", "ChapterNavierStokesSignedShift",
    "ChapterFriedrichsExtension", "ChapterNavierStokesCanonicalVector",
    "ChapterNavierStokesDifferentialL2", "ChapterSirkSpectralGeometry",
    "ChapterHyperbolicQuadraticEsa", "ChapterNavierStokesHashimoto",
    "ChapterNavierStokesLagrangianKatoRellich", "ChapterSirkPerSystem",
    "ChapterSirkRestart", "ChapterSirkRitzSpectrum", "ChapterSirkTruncation",
    "ChapterSirkGramWhitening", "ChapterSirkGramCutoff", "ChapterSirkTrotterKato",
    "ChapterSirkMultiShift", "ChapterSirkTrotterKatoGalerkin", "ChapterSirkGapTable",
    "ChapterSirkRitzPerturbation", "ChapterNavierStokesHermiteCanonical",
    "ChapterSirkCertificateReader", "ChapterFockSecondQuantization",
    "ChapterFockOneParticleGap", "ChapterBandEnclosure", "ChapterFriedrichsFormGap",
    "ChapterNavierStokesFarisLavineLift", "ChapterNavierStokesDiffFarisLavine",
    "ChapterNavierStokesSecondQuant", "ChapterWeylHamiltonian",
    "ChapterH5", "ChapterH6", "ChapterH7", "ChapterH8", "ChapterH8Bases", "ChapterH9",
    "ChapterTrajectory", "ChapterU", "ChapterUnboundedPosition", "ChapterUnitaryTransport",
    "ChapterWeakSecondDerivative", "ChapterScalaronEdge",
]

NODE_MIN = 40
PROMO_MIN = 11


class ByteText:
    """Source text with byte-offset -> code-point-index conversion."""

    def __init__(self, text):
        self.text = text
        self.b2c = [0] * (len(text.encode("utf-8")) + 1)
        b = 0
        for i, ch in enumerate(text):
            self.b2c[b] = i
            b += len(ch.encode("utf-8"))
        self.b2c[b] = len(text)

    def slice(self, bstart, bend):
        return self.text[self.b2c[bstart]:self.b2c[bend]]


class Decl:
    def __init__(self, d, leaf):
        self.leaf = leaf
        self.module = f"BookProof.{leaf}"
        self.name_text = d.get("nameText")
        self.s = d["declStart"]["offset"]
        self.e = d["declEnd"]["offset"]
        self.sl = d["declStart"]["line"]
        self.el = d["declEnd"]["line"]
        vs = d.get("valStart")
        self.vs = vs["offset"] if vs else None
        self.vsl = vs["line"] if vs else None
        self.val_kind = d.get("valKind")
        self.doc = d.get("docstring") is not None
        self.gname = None
        self.uname = None
        self.kind = None
        self.is_private = False
        self.is_instance = False
        self.tdeps = []
        self.vdeps = []

    @property
    def plen(self):
        return (self.el - self.vsl) if self.vsl is not None else 0

    def short(self):
        return self.uname.split(".")[-1] if self.uname else self.name_text

    def parent_ns(self):
        if not self.uname:
            return ""
        return ".".join(self.uname.split(".")[:-1])

    def __repr__(self):
        return (f"<{self.short()} {self.kind} priv={int(self.is_private)} "
                f"L{self.sl}-{self.el} plen={self.plen}>")


def load_graph():
    g = {}
    with open(GRAPH) as f:
        for line in f:
            r = json.loads(line)
            g.setdefault(r["module"], []).append(r)
    return g


def load_decls(leaf, g):
    facts = []
    with open(f"{SKETCH_DIR}/sketch_{leaf}.jsonl") as f:
        for line in f:
            r = json.loads(line)
            if r["kind"] == "decl":
                facts.append(Decl(r, leaf))
    facts.sort(key=lambda d: d.s)
    # Guard against a sketch/space mismatch: the sketch offsets must fit inside
    # the source the generator will slice.  A split chapter whose monolith could
    # not be recovered (or a stale sketch for a rewritten chapter) would
    # otherwise raise a bare IndexError deep inside ByteText.slice, or worse,
    # slice a wrong-but-in-range span silently.
    if facts:
        size = os.path.getsize(src_path_for(leaf))
        over = max(d.e for d in facts) > size
        if over:
            raise RuntimeError(
                f"{leaf}: sketch offsets exceed the source text "
                f"({max(d.e for d in facts)} > {size} bytes at "
                f"{src_path_for(leaf)}) -- the sketch indexes a different "
                f"source layout; refusing to slice")
        # A stale sketch can also land *inside* the source: every offset is in
        # range, so `over` passes, but the slice starts mid-declaration and the
        # emitted bundle contains fragments like `irst | rfl | ring)`.
        #
        # Validate by LINE, not by byte offset: `declStart.line` is what the
        # decl graph is keyed on, and a byte offset is unreliable here because
        # the sketch reports byte positions while slicing must agree with it
        # exactly (chapters are full of multi-byte math symbols). Line numbers
        # are immune to that.
        lines = open(src_path_for(leaf), encoding="utf-8", errors="replace").read().split("\n")
        opener = re.compile(
            r"^(?:@\[[^\]]*\]\s*)?"
            r"(?:private\s+|protected\s+|nonrec\s+|noncomputable\s+)*"
            r"(?:theorem|lemma|def|abbrev|instance|example|structure|inductive|"
            r"class|axiom|opaque)\b")

        def decl_line_ok(lineno):
            """Walk forward from a span's first line past comments and
            `omit ... in`, then require an actual declaration keyword."""
            i = max(0, lineno - 1)
            in_doc = False
            while i < min(len(lines), lineno + 400):
                ln = lines[i].strip()
                i += 1
                if in_doc:
                    if "-/" in ln:
                        in_doc = False
                    continue
                if ln.startswith("/--"):
                    if "-/" not in ln[3:]:
                        in_doc = True
                    continue
                if ln.startswith("/-"):
                    if "-/" not in ln[2:]:
                        in_doc = True
                    continue
                if ln.startswith("--") or not ln:
                    continue
                ln = re.sub(r"^omit\s+\[[^\]]*\]\s+in\s+", "", ln)
                return bool(opener.match(ln))
            return False

        misaligned = [d.name_text or f"line {d.sl}" for d in facts
                      if not decl_line_ok(d.sl)]
        if misaligned:
            # Advisory only. `declStart.line` is demonstrably unreliable in
            # chapters whose docstrings span many lines (the sketch sometimes
            # points at the docstring body or its `-/`), so raising here would
            # block regeneration of perfectly good chapters. The byte-offset
            # check above is the hard guard against out-of-range slicing; this
            # one only reports spans whose recorded line disagrees with the
            # source, which usually means the sketch predates an edit.
            print(f"  WARNING {leaf}: {len(misaligned)}/{len(facts)} sketch "
                  f"spans look misaligned (first: {misaligned[0]}); the sketch "
                  f"may predate edits to {src_path_for(leaf)} -- refresh with "
                  f"scripts/run_sketch_all.py if the output looks garbled",
                  file=sys.stderr)
    grows = [x for x in g.get(f"BookProof.{leaf}", []) if x["startLine"] > 0]
    for d in facts:
        cands = [x for x in grows if d.sl <= x["startLine"] <= d.el]
        if not cands:
            continue
        exact = [x for x in cands
                 if d.name_text and x["userName"].split(".")[-1] == d.name_text]
        x = (exact or cands)[0]
        d.gname, d.uname, d.kind = x["name"], x["userName"], x["kind"]
        d.is_private = x["isPrivate"]
        d.is_instance = x["isInstance"]
        d.tdeps = x.get("typeDeps", [])
        d.vdeps = x.get("valueDeps", [])
    return facts


def classify(decls, module_doc):
    short = {d.short(): d for d in decls}
    defmat = {d for d in decls
              if not d.is_private and d.kind in ("def", "inductive")}
    defmat |= {d for d in decls if d.is_instance}
    embedded = set()
    changed = True
    while changed:
        changed = False
        for d in list(defmat) + list(embedded):
            for dep in d.vdeps:
                c = short.get(dep.split(".")[-1])
                if c and c.kind == "theorem" and c not in defmat \
                        and c not in embedded:
                    embedded.add(c)
                    changed = True
    # Transplant rule (matches the batch-1 pilot and the playbook's goal of a
    # fully-Proved dependency graph): EVERY public theorem is a node.  Only
    # private theorems inline (file-scoped, pasted into consuming solutions).
    nodes = {d for d in decls
             if d.kind == "theorem" and not d.is_private
             and d not in defmat and d not in embedded}
    inline = {d for d in decls if d.kind == "theorem" and d not in nodes
              and d not in defmat and d not in embedded}
    return defmat, embedded, nodes, inline


# The Aristotle snapshot (timepiece a5fcf4a, 2026-09-15) split many chapters from
# one file into a directory of `Part1.lean …` files.  The sketch oracle and the
# declaration graph were built from the PRE-SPLIT monolith and store byte
# offsets / line numbers in its space, so every consumer of sketch offsets must
# read that same text.  Chapters split this way are recovered from git at the
# last commit that touched the aggregator (the split commit) and cached under
# state/sketch/monolith/; a chapter that is still a plain file is read directly.
# Note the monolith is deliberately the *old* text: statements and proofs are cut
# from what the sketch and graph describe, which is the only self-consistent view.
SPLIT_SENTINEL_DIRS = True

_monolith_cache = {}


def src_path_for(leaf):
    """Path of the source text this leaf's sketch and graph rows index.

    For a split chapter (a `BookProof/<leaf>/` directory of parts) that is the
    pre-split monolith, materialised from git and cached; otherwise the plain
    file.  Raises when a split chapter has no recoverable monolith rather than
    silently slicing the wrong file (an offset past the aggregator's end is the
    IndexError that blocked ChapterScalaronCoreEsa / ChapterScalaronFiberFL and
    with them the def head's five-node import closure)."""
    # Prefer the CURRENT aggregator when it exists, even for a split chapter.
    #
    # The monolith path was right when the aggregator was just a wrapper around
    # identical parts. It is wrong now for two reasons. (1) The sketch has to
    # index whatever is sliced, and re-extracting a monolith is not always
    # possible: `extract_sketch_info` re-elaborates the file, and several
    # monoliths no longer typecheck against the current Mathlib (Type mismatch
    # after simplification, from deprecated simp lemmas), so they cannot be
    # re-indexed at all. (2) The cached sketches were built against the
    # aggregator for some of these leaves -- ChapterNavierStokesFockEsa's max
    # offset is 30335 against a 29983-byte monolith -- so sketch and slice
    # disagreed and the bundle was silently wrong.
    #
    # Slicing the aggregator keeps sketch, slice and the passing build in
    # agreement. The monolith remains the fallback for a split chapter whose
    # aggregator is missing.
    plain = f"{PROJ}/BookProof/{leaf}.lean"
    if os.path.exists(plain):
        return plain
    if os.path.isdir(f"{PROJ}/BookProof/{leaf}"):
        p = _monolith_cache.get(leaf)
        if p is None:
            d = f"{WS}/state/sketch/monolith"
            os.makedirs(d, exist_ok=True)
            p = f"{d}/{leaf}.lean"
            if not os.path.exists(p):
                # The last commit that touched the aggregator is the split
                # commit; its parent still has the monolith.
                r = subprocess.run(
                    ["git", "-C", PROJ, "log", "-1", "--format=%H", "--",
                     f"BookProof/{leaf}.lean"],
                    capture_output=True, text=True, timeout=120)
                split = r.stdout.strip()
                got = ""
                if split:
                    r2 = subprocess.run(
                        ["git", "-C", PROJ, "show", f"{split}^:BookProof/{leaf}.lean"],
                        capture_output=True, text=True, timeout=120)
                    got = r2.stdout if r2.returncode == 0 else ""
                if not got.strip():
                    raise RuntimeError(
                        f"{leaf}: split into parts and no monolith recoverable "
                        f"from git ({(r.stderr or r2.stderr if split else r.stderr)[:200]})")
                with open(p, "w", encoding="utf-8") as f:
                    f.write(got)
            _monolith_cache[leaf] = p
        return p
    return f"{PROJ}/BookProof/{leaf}.lean"


def src_byte_text(leaf):
    path = src_path_for(leaf)
    print(f"DEBUG src_byte_text: leaf={leaf}, path={path}, is_file={os.path.isfile(path)}", file=sys.stderr)
    with open(path, encoding="utf-8") as f:
        return ByteText(f.read())


def structural_preamble(bt, upto_byte):
    """Lines from the source before upto_byte that are structural context:
    open/open scoped/variable/include/set_option/noncomputable section/universe
    (+ blank lines).  import lines are dropped (the generator emits its own),
    namespace/section/end lines and all declaration/doc content are dropped.

    A multi-line `variable` command keeps its indented continuation lines
    (e.g. a `[FiniteDimensional ℂ E]` instance on its own line).  Per-declaration
    wrappers ending in ` in` (`omit … in`, `set_option … in`, `include … in`,
    `open … in`) are NOT structural: Stage 2's decl facts already put them inside
    the wrapped declaration's span, so hoisting them here would attach them to
    the wrong (or no) declaration.

    Block comments are skipped wholesale: a module docstring or `/-! -/` section
    header can contain a line whose prose starts with e.g. "open " (the
    ScalaronCoreEsa docstring has "open at the *continuum* level …"), and
    hoisting that into the emitted preamble produced a stub that does not
    parse.  Comment state is tracked linearly: `/- … -/` blocks nest, `--` runs
    to end of line, and a `"…"` string inside code protects its contents."""
    pre = bt.slice(0, upto_byte)
    out = []
    in_variable = False
    depth = 0          # nesting depth of /- -/ block comments
    in_str = False     # inside a Lean string literal
    for line in pre.split("\n"):
        if depth > 0:
            # inside a block comment: only track nesting
            i = 0
            while i < len(line):
                if line.startswith("/-", i):
                    depth += 1
                    i += 2
                elif line.startswith("-/", i):
                    depth -= 1
                    i += 2
                else:
                    i += 1
            continue
        # scan the line once to classify it (code / line comment / string)
        code = []
        i = 0
        while i < len(line):
            if in_str:
                if line[i] == "\\" and i + 1 < len(line):
                    i += 2
                    continue
                if line[i] == '"':
                    in_str = False
                i += 1
                continue
            if line.startswith("/-", i):
                depth += 1
                i += 2
                continue
            if line.startswith("-/", i):
                i += 2
                continue
            if line.startswith("--", i):
                break  # line comment: rest of the line ignored
            if line[i] == '"':
                in_str = True
                i += 1
                continue
            code.append(line[i])
            i += 1
        s = "".join(code).strip()
        if in_variable and s and line[:1].isspace():
            # continuation line of a multi-line `variable` command
            out.append(line)
            continue
        in_variable = False
        if s.endswith(" in"):
            # per-declaration wrapper: belongs to its own declaration's span
            continue
        if re.match(r"^(open |open scoped |variable |include "
                    r"|omit |set_option |noncomputable section|universe "
                    r"|attribute |local notation|notation )", s):
            out.append(line)
            in_variable = s.startswith("variable ")
        elif s == "":
            out.append("")
    res = "\n".join(out).rstrip()
    return res


def the_statement(bt, d):
    frag = bt.slice(d.s, d.vs)
    frag = re.sub(r"^/--(?:.*?)-/\s*", "", frag, flags=re.S).rstrip()
    frag = re.sub(r":=\s*$", "", frag).rstrip()
    return frag


def the_proof(bt, d):
    """Return (body, mode) where mode is 'tactic' when the source proof starts
    with `by` (a tactic block) and 'term' when it is a plain term (`:= rfl`,
    `:= ⟨a, b⟩`, `:= someTheorem x y`, …).  Tactic bodies keep their source
    indentation; term bodies are emitted directly after `:=` (never under a
    `by` block, which cannot contain `⟨…⟩` constructor syntax)."""
    frag = bt.slice(d.vs, d.e)
    frag = re.sub(r"^\s*:=\s*", "", frag)
    if re.match(r"^\s*by\b", frag):
        return re.sub(r"^\s*by\b", "", frag), "tactic"
    return frag, "term"


def fmt_name(stmt, newname):
    """Rename the declaration in `stmt` to `theorem {newname}`, skipping any
    leading wrappers: attributes (`@[simp]`), `omit … in` / `set_option … in`
    modifiers, and `/-- -/` or `/- -/` comments.  (Doc comments are NOT part of
    the uploaded statement, but wrapped declarations keep their `/- -/` block
    comment and `omit … in` prefix inside the decl span.)  The rename happens at
    the FIRST `theorem|lemma` keyword after those wrappers."""
    m = re.search(
        r"(?:(?:@\[[^\]]*\]|omit\s+\[[^\]]*\]\s+in|"
        r"set_option\s+[^\n]*?\s+in|/--(?:.*?)-/|/-(?:.*?)-/)\s*)*"
        r"(?:(?:protected|private|unsafe|noncomputable|partial)\s+)*"
        r"(?:theorem|lemma)\s+[A-Za-z0-9_.']+",
        stmt, flags=re.S)
    if not m:
        return stmt
    return stmt[:m.start()] + f"theorem {newname}" + stmt[m.end():]


_THM_INDEX = None
_NAME_OWNER = None
_NS_OWNER = None
_NS_TO_OWNER = None


def thm_node_index():
    """`short name -> [(full name, slug)]` for every generated `Theorems/` stub.

    WHY THIS EXISTS
    ---------------
    A node's solution may cite a declaration that is a **node in another
    chapter** (e.g. `ScalaronWallEsa.kinCcR_symmetricOn` proves its statement
    from `StrichartzWave.constCoeffOp_symmetric` and
    `ScalaronCoreEsa.symmetricOn_inclusion`).  The transplant rule makes every
    public theorem a node, so such a declaration is *not* in any `Def_*` bundle:
    it lives in `Theorems/Thm_<slug>.lean`.  The platform compiles a solution
    against the published modules only, so without that import the reference is
    "Unknown identifier" -- the CE class that dominated the wave after the
    2026-09-17 append (e.g. `momPoly_apply`, `HermiteProductCore.pgMap_apply`).

    `build_sol` already imported siblings *within* the chapter (`node_deps`);
    this index extends the same rule across chapters, and only ever emits an
    import for a stub that exists on disk, so a missing node stays a missing
    node instead of becoming an unknown-import failure.
    """
    global _THM_INDEX
    if _THM_INDEX is None:
        _THM_INDEX = {}
        for p in glob.glob(f"{OUT_THM}/Thm_*.lean"):
            try:
                with open(p, encoding="utf-8") as f:
                    txt = f.read()
            except OSError:
                continue
            m = re.search(r"(?m)^theorem\s+([A-Za-z_][\w.']*)", txt)
            if not m:
                continue
            slug = os.path.basename(p)[len("Thm_"):-len(".lean")]
            _THM_INDEX.setdefault(m.group(1).split(".")[-1], []).append(
                (m.group(1), slug))
    return _THM_INDEX


def index_register(fullname, slug):
    """Add a stub written during THIS run to the index, so a later chapter's
    solution can import it.  (The index is memoised; without this, a cross-chapter
    dep generated earlier in the same invocation would be invisible.)"""
    idx = thm_node_index()
    entry = (fullname, slug)
    bucket = idx.setdefault(fullname.split(".")[-1], [])
    if entry not in bucket:
        bucket.append(entry)


def cross_chapter_imports(node, nodes, inline):
    """`import Theorems.Thm_<slug>` lines for this node's cited declarations that
    are nodes of OTHER chapters.  Sibling chapters are handled by `node_deps`.

    A cited name is dropped when it is ambiguous (two stubs declaring the same
    short name and neither an exact full-name match): an over-eager import of
    the wrong node would shadow the intended one.
    """
    local = {o.short() for o in nodes}
    inlined = {d.short() for d in inline}
    index = thm_node_index()
    out = set()
    for dep in list(node.vdeps) + list(getattr(node, "tdeps", [])):
        short = dep.split(".")[-1]
        if short in local or short in inlined:
            continue
        cands = index.get(short)
        if not cands:
            continue
        exact = [s for full, s in cands if full == dep or dep.endswith("." + full)]
        if len(exact) == 1:
            out.add(exact[0])
        elif not exact and len(cands) == 1:
            out.add(cands[0][1])
    return [f"import Theorems.Thm_{s}\n" for s in sorted(out)]


def collect_inline_closure(node, decls, inline):
    short = {d.short(): d for d in decls}
    needed = set()
    work = {node}
    while work:
        o = work.pop()
        for dep in o.vdeps:
            c = short.get(dep.split(".")[-1])
            if c and c in inline and c not in needed:
                needed.add(c)
                work.add(c)
    return needed


def opens_for(node, modns):
    """Namespaces to open so the node's statement resolves: the module
    namespace `modns` (brings the types into scope) plus the node's
    parent namespace when it is nested deeper (e.g. `CertInterval`'s members).
    A nested `open A.B.C` alone does NOT put the structure `A.B.C` in scope."""
    parent = node.parent_ns()
    opens = [modns]
    if parent and parent != modns:
        opens.append(parent)
    return opens


def module_namespace(leaf):
    """The `namespace X` that the chapter's declarations live in.  The graph
    module is `BookProof.Chapter<Name>` but the namespace is `BookProof.<Name>`
    (e.g. ChapterSirkFinitePrecision -> BookProof.SirkFinitePrecision).  Grab it
    from the first `namespace` command in the source."""
    with open(src_path_for(leaf), encoding="utf-8") as f:
        text = f.read()
    m = re.search(r"^namespace (BookProof\.[A-Za-z0-9_'.]+)", text, re.M)
    if m:
        return m.group(1)
    return f"BookProof.{leaf.removeprefix('Chapter')}"


def upstream_def_imports(source_text, leaf):
    """Parse source for `import BookProof.ChapterX` and `import BookProof.X`
    lines and return corresponding `import Definitions.Def_ChapterX` module paths
    for each one whose Def file exists."""
    imports = []
    seen = set()
    # Match import BookProof.Chapter<Name> (with or without .lean)
    for m in re.finditer(r"^import BookProof\.Chapter([A-Za-z0-9]+)(?:\.lean)?", source_text, re.M):
        name = m.group(1)
        if name in seen:
            continue
        seen.add(name)
        def_file = f"Def_Chapter{name}.lean"
        if os.path.exists(f"{OUT_DEF}/{def_file}"):
            imports.append(f"import Definitions.Def_Chapter{name}")
    # Match import BookProof.<Name> (direct, no Chapter prefix)
    for m in re.finditer(r"^import BookProof\.([A-Z][A-Za-z0-9]*)", source_text, re.M):
        name = m.group(1)
        if name in seen:
            continue
        seen.add(name)
        def_file = f"Def_Chapter{name}.lean"
        if os.path.exists(f"{OUT_DEF}/{def_file}"):
            imports.append(f"import Definitions.Def_Chapter{name}")
    return imports


def namespace_to_owner():
    """namespace -> the bundle that declares it, from the platform index."""
    global _NS_TO_OWNER
    if _NS_TO_OWNER is None:
        _NS_TO_OWNER = {}
        try:
            idx = json.load(open(f"{WS}/state/defs_index.json"))
        except Exception:
            return {}
        _NS_TO_OWNER.update(idx.get("namespace_owner") or {})
    return _NS_TO_OWNER


def owner_of_namespace(ns):
    """Bundle that declares `ns`, tolerating nested namespaces.

    The index records `namespace BookProof.HashimotoShiftInvert` and
    `namespace IsShiftInvert` as two separate entries, so a lookup of the dotted
    path `BookProof.HashimotoShiftInvert.IsShiftInvert` misses -- and an `open`
    of it then fails with `unknown namespace` because nothing imported the
    bundle. Fall back to the longest declared prefix.
    """
    table = namespace_to_owner()
    if ns in table:
        return table[ns]
    parts = ns.split(".")
    for k in range(len(parts) - 1, 0, -1):
        prefix = ".".join(parts[:k])
        if prefix in table:
            return table[prefix]
    return None


def namespace_owner_map():
    """bundle -> the namespaces it declares, from the platform index."""
    global _NS_OWNER
    if _NS_OWNER is None:
        _NS_OWNER = {}
        try:
            idx = json.load(open(f"{WS}/state/defs_index.json"))
        except Exception:
            return {}
        for ns, owner in (idx.get("namespace_owner") or {}).items():
            _NS_OWNER.setdefault(owner, []).append(ns)
    return _NS_OWNER


def name_owner_map():
    """bare declaration name -> the Def bundle that declares it.

    Built from the platform index (`state/defs_index.json`), so it reflects what
    is actually published rather than what this checkout happens to contain.
    """
    global _NAME_OWNER
    if _NAME_OWNER is None:
        _NAME_OWNER = {}
        try:
            idx = json.load(open(f"{WS}/state/defs_index.json"))
        except Exception:
            return {}
        for bare, owner in (idx.get("name_owner") or {}).items():
            _NAME_OWNER.setdefault(bare.split(".")[-1], owner)
    return _NAME_OWNER


def dep_def_imports(leaf, node):
    """`import Definitions.Def_X` lines for the chapters owning this node's deps.

    WHY: a theorem's statement can mention a name that no bundle it imports
    declares. `Thm_BookProof_QgHermiteCore_memLp_mul_pgFun_of_expBounded`
    mentions `Vd`, which `Def_ChapterHermiteProductCore` declares and
    `Def_ChapterQgHermiteCore` does not -- so the stub failed with
    `Function expected at Vd`, `Vd` resolving to the type synonym rather than
    the function. The def bundles got the same treatment in `build_def_file`
    (cross-chapter theorem imports); this is the mirror image of it.
    """
    owners = name_owner_map()
    if not owners:
        return []
    out = set()
    for dep in list(getattr(node, "tdeps", []) or []) + list(getattr(node, "vdeps", []) or []):
        short = dep.split(".")[-1]
        owner = owners.get(short)
        if owner and owner != leaf:
            out.add(owner)
    lines = []
    for o in sorted(out):
        lines.append(f"import Definitions.Def_{o}")
        # An import alone does not put the owner's names in scope unqualified:
        # `Vd` is declared inside `namespace BookProof.HermiteProductCore`, so a
        # stub that imports Def_ChapterHermiteProductCore without opening that
        # namespace still fails with `Function expected at Vd`. Open whatever the
        # owner declares.
        for ns in namespace_owner_map().get(o, ()):
            lines.append(f"open {ns}")
    return lines


def imports_for(leaf, node, modns):
    # ALL imports first, then all `open`s. Lean requires every `import` at the
    # top of the file; interleaving them with `open` fails with "`import`
    # command, it must be used in the beginning of the file".
    imports, seen = [], set()
    for ln in ["import Mathlib", f"import Definitions.Def_{leaf}"] + \
            [l for l in dep_def_imports(leaf, node) if l.startswith("import")]:
        if ln not in seen:
            seen.add(ln)
            imports.append(ln)
    opens = [l for l in dep_def_imports(leaf, node) if l.startswith("open ")]
    for ns in opens_for(node, modns):
        line = f"open {ns}"
        if line not in opens:
            opens.append(line)
        # An `open` of a namespace nothing declares is `unknown namespace`, so
        # import the bundle that provides it. `open BookProof.YangMillsFriedrichs`
        # needs Def_ChapterYangMillsFriedrichs to be in scope first.
        # `opens_for` can return a combined line -- `open BookProof.FarisLavine
        # BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension` -- so each
        # namespace has to be looked up separately or the provider import is
        # missed and the open fails with `unknown namespace`.
        for one in ns.split():
            owner = owner_of_namespace(one)
            if owner and owner != leaf:
                imp = f"import Definitions.Def_{owner}"
                if imp not in imports:
                    imports.append(imp)
    return "\n".join(imports + opens)


def extract_namespace_variables(bt, upto_line=None):
    """Every top-level `variable` command in the chapter, as source lines.

    WHY THIS MATTERS: a stub that references a type the chapter only ever bound
    with `variable` will not elaborate. 51 pending statements failed with
    `failed to synthesize instance of type class TopologicalSpace F` because
    ChapterH6 declares `variable {E F : Type*}` at line 95 and the stub emitted
    neither it nor anything else, so `F` and `E` were undeclared. The previous
    implementation scanned only the first 5000 bytes and returned an empty
    string for most chapters.

    Lean's `variable` is section-scoped, so collecting all of them is safe: a
    binder the theorem does not use is simply unused. Multi-line declarations
    (a `variable` continued onto an indented line) are kept together.
    """
    lines = bt.text.split("\n")
    out = []
    seen_sig = set()
    depth = 0
    i = 0
    # Only variables declared BEFORE the theorem. Collecting the whole file
    # shadowed the theorem's own `d` with a `d` from a later section, so `W` got
    # type `Vd d-vs-d` and elaboration failed with `Application type mismatch`
    # on `hamCore W` -- while the binder names looked perfectly correct.
    limit = upto_line if upto_line else len(lines) + 1
    n = min(len(lines), limit)
    while i < n:
        line = lines[i]
        stripped = line.strip()
        if depth > 0:
            # inside a block comment: watch for the closer
            depth += line.count("/-") - line.count("-/")
            if depth < 0:
                depth = 0
            i += 1
            continue
        if stripped.startswith("/-"):
            depth = stripped.count("/-") - stripped.count("-/")
            if depth <= 0:
                depth = 0
            i += 1
            continue
        if stripped.startswith("--") or not stripped:
            i += 1
            continue
        if stripped.startswith("variable") and (
                len(stripped) == 8 or not stripped[8].isalnum()):
            block = [line]
            # absorb indented continuation lines
            j = i + 1
            while j < n and lines[j][:1].isspace() and lines[j].strip() \
                    and not lines[j].strip().startswith(("--", "/-", "theorem", "lemma",
                                                        "def", "abbrev", "instance", "structure",
                                                        "end", "noncomputable", "variable", "open", "namespace")):
                block.append(lines[j])
                j += 1
            sig = " ".join(x.strip() for x in block)
            if sig not in seen_sig:
                seen_sig.add(sig)
                out.extend(block)
            i = j
            continue
        i += 1
    return "\n".join(out)


def build_thm(bt, leaf, decls, node, modns):
    ctx = structural_preamble(bt, node.s)
    stmt = fmt_name(the_statement(bt, node), node.uname)
    head = [f"-- Generated from {leaf}.lean — theorem {node.uname}\n"]
    head.append(imports_for(leaf, node, modns) + "\n")
    
    # Add namespace-level variables if any
    try:
        ns_vars = extract_namespace_variables(bt, getattr(node, "sl", None))
        if ns_vars:
            head.append("\n" + ns_vars + "\n")
    except Exception as e:
        # Log but don't fail
            print(f"WARNING: extract_namespace_variables failed for {leaf}: {e}", file=sys.stderr)
    
    if ctx:
        head.append(ctx + "\n")
    head.append("\n")
    head.append(stmt + " := by sorry\n")
    text = "".join(head)
    # Drop duplicate `variable` lines. The same declaration can arrive twice --
    # once from extract_namespace_variables and once from the copied context --
    # and Lean's auto-bound `d` then shadows the theorem's own `d`, so `W` picks
    # up type `Vd d<vs>` and `hamCore W` fails with `Application type mismatch`.
    _seen_var = set()
    _kept = []
    _lines = text.split("\n")
    _i = 0
    while _i < len(_lines):
        _ln = _lines[_i]
        _st = _ln.strip()
        if not _st.startswith("variable "):
            _kept.append(_ln)
            _i += 1
            continue
        # A multi-line `variable` is its first line plus the indented lines that
        # follow. Dedupe the whole block: dropping only the first line left an
        # orphaned `  [MeasurableSpace E] [BorelSpace E]` that failed with
        # `unexpected token '['`.
        _block = [_ln]
        _j = _i + 1
        while (_j < len(_lines) and _lines[_j][:1].isspace()
               and _lines[_j].strip()
               and not _lines[_j].strip().startswith(("theorem", "lemma", "def",
                                                      "abbrev", "instance", "structure",
                                                      "end", "namespace", "open", "import"))):
            _block.append(_lines[_j])
            _j += 1
        _sig = " ".join(x.strip() for x in _block)
        if _sig not in _seen_var:
            _seen_var.add(_sig)
            _kept.extend(_block)
        _i = _j
    text = "\n".join(_kept)
    # Drop `open` of BookProof namespaces the platform index does not declare.
    # A section is not a namespace: `section IsShiftInvert` inside
    # `namespace BookProof.HashimotoShiftInvert` creates no
    # `BookProof.HashimotoShiftInvert.IsShiftInvert`, so opening it is
    # `unknown namespace` -- and the stub was inventing it. Our own namespaces
    # are the index's business, so it is authoritative here; Mathlib's are not
    # indexed, which is why the filter is scoped to BookProof.
    _known = set(namespace_to_owner())
    _drop = []
    for _i, _ln in enumerate(text.split("\n")):
        _st = _ln.strip()
        if _st.startswith("open BookProof."):
            for _one in _st.split()[1:]:
                if _one.startswith("BookProof.") and _one not in _known:
                    _drop.append((_i, _one))
                    break
    if _drop:
        _lines = text.split("\n")
        _bad = {i for i, _ in _drop}
        text = "\n".join(l for i, l in enumerate(_lines) if i not in _bad)
        for _i, _one in _drop:
            print(f"  WARNING dropped `open {_one}`: no bundle declares it",
                  file=sys.stderr)
    # The copied context can `open` namespaces the header never mentions (e.g.
    # `open BookProof.FarisLavine BookProof.YangMillsFriedrichs
    # BookProof.FriedrichsExtension` from the source), and an open of a namespace
    # nothing declares is `unknown namespace`. Add each one's provider import.
    # Imports have to go at the very top, so this runs on the assembled text.
    have = set(re.findall(r"(?m)^import\s+(\S+)", text))
    extra = []
    for line in re.findall(r"(?m)^open\s+(.+)$", text):
        for one in line.split():
            if not one.startswith("BookProof."):
                continue
            owner = owner_of_namespace(one)
            if not owner:
                continue
            mod = f"Definitions.Def_{owner}"
            if mod not in have:
                have.add(mod)
                extra.append(f"import {mod}")
    if extra:
        first = text.index("\n")
        text = text[:first + 1] + "\n".join(extra) + "\n" + text[first + 1:]
    return text


def build_sol(bt, leaf, decls, nodes, inline, node, modns):
    ctx = structural_preamble(bt, node.s)
    stmt = fmt_name(the_statement(bt, node), "solution")
    proof, mode = the_proof(bt, node)
    needed = collect_inline_closure(node, decls, inline)
    node_deps = sorted({o for o in nodes
                        if o is not node
                        and any(dep.split(".")[-1] == o.short()
                                for dep in node.vdeps)},
                       key=lambda o: o.s)
    parts = [f"-- Generated from {leaf}.lean — solution of {node.uname}\n"]
    parts.append("import Mathlib\n")
    parts.append(f"import Definitions.Def_{leaf}\n")
    for o in node_deps:
        parts.append(f"import Theorems.Thm_{o.uname.replace('.', '_')}\n")
    parts.extend(cross_chapter_imports(node, nodes, inline))
    for ns in opens_for(node, modns):
        parts.append(f"open {ns}\n")
    if ctx:
        parts.append("\n" + ctx + "\n")
    for h in sorted(needed, key=lambda x: x.s):
        frag = re.sub(r"^/--(?:.*?)-/\s*", "", bt.slice(h.s, h.e),
                      flags=re.S).rstrip()
        frag = re.sub(r"^omit\s+\[[^\]\n]*\]\s+in\s*", "", frag)
        parts.append(frag + "\n")
    parts.append("\n")
    parts.append("set_option maxHeartbeats 1000000 in\n")
    if node.val_kind == "eqns":
        # Equation-style theorem: the source value is a pattern-matching
        # sequence over the binders (`| pat => proof` arms) with NO `:=`.
        # Reproduce the shape exactly — `theorem solution : …` followed by
        # the arms on their own indented lines.  Recursive self-calls inside
        # the arms refer to the old name; after the rename they must point at
        # `solution` (nothing else with that short name is in scope here, so a
        # bare-word rewrite of the declaration's own short name is exact).
        short = node.short()
        proof = re.sub(rf"\b{re.escape(short)}\b", "solution", proof)
        parts.append(stmt.rstrip() + "\n")
        parts.append(proof if proof.endswith("\n") else proof + "\n")
    elif mode == "term":
        # term-mode proof: `:= <term>` (a `by` block cannot hold `⟨…⟩` or
        # bare `| … =>` match arms).  A single-line term like `rfl` or
        # `hnone lam0 hlam0` is emitted inline after `:= `; a multi-line term
        # (e.g. `⟨…⟩` spanning lines) goes on the next line with each line
        # indented 2 spaces relative to the declaration.
        if "\n" in proof:
            ind = "\n  " + "\n  ".join(proof.split("\n")).rstrip()
            parts.append(stmt + " :=" + ind + "\n")
        else:
            parts.append(stmt + " := " + proof.strip() + "\n")
    else:
        parts.append(stmt + " := by\n")
        parts.append(proof if proof.endswith("\n") else proof + "\n")
    return "".join(parts)


def build_def_file(bt, leaf, decls, defmat, embedded):
    keep = defmat | embedded
    if not keep:
        return None
    graph = load_graph()
    # Lightweight stand-ins for the graph rows. `Decl` cannot take a graph row:
    # it reads `declStart`/`declEnd`, which only the sketch has, so building one
    # from a graph row raises KeyError. All `cross_chapter_imports` needs is the
    # declared name and the dependency lists.
    class _Row:
        __slots__ = ("userName", "kind", "vdeps", "tdeps", "is_instance")

        def __init__(self, r):
            self.userName = r.get("userName") or r.get("name") or ""
            self.kind = r.get("kind")
            self.vdeps = r.get("valueDeps") or []
            self.tdeps = r.get("typeDeps") or []
            self.is_instance = bool(r.get("isInstance"))

        def short(self):
            return self.userName.split(".")[-1]

    nodes = [_Row(r) for r in graph.get(f"BookProof.{leaf}", [])]
    inline = set()
    # Skeleton subtraction: walk the file in order, keeping the text between
    # declarations verbatim but DELETING every unselected declaration span.
    parts = []
    pos = 0
    for d in sorted(decls, key=lambda x: x.s):
        if d.s > pos:
            parts.append(bt.slice(pos, d.s))
        if d in keep:
            parts.append(bt.slice(d.s, d.e))
        pos = d.e
    parts.append(bt.slice(pos, len(bt.text.encode("utf-8"))))
    text = "".join(parts)
    # Strip BookProof.* imports — cross-chapter deps become upstream Def
    # imports below.  KEEP `open BookProof.*` lines: the namespaces are
    # declared by the upstream Def bundles, and bundle bodies reference the
    # opened identifiers unqualified.
    text = re.sub(r"^import BookProof\.[^\n]*\n", "", text, flags=re.M)
    # Add upstream Def imports for BookProof.ChapterX imports.
    src_text = bt.text
    upstream = upstream_def_imports(src_text, leaf)
    # Always emit `import Mathlib` + upstream imports at the top: the source may
    # import only `BookProof.Prelude` (which itself imports Mathlib), so after
    # stripping BookProof.* imports the bundle would have NO imports at all.
    head = ["import Mathlib"]
    if upstream:
        head = upstream + head
    # Cross-chapter theorem imports. A def body can cite a declaration that the
    # transplant rule puts in the theorem layer rather than in any Def bundle,
    # because that declaration is a public theorem (e.g.
    # `NavierStokesFlow.FockOfFock.fockDom_dense` is proved from names in another
    # chapter, so it lives in `Theorems/Thm_..._fockDom_dense.lean`). Without
    # this the reference is `Unknown identifier` on the platform, and because the
    # whole `BookProof.*` import block was stripped above, nothing else supplies
    # it. `build_sol` has emitted these since the 2026-09-17 append; def bundles
    # did not, which is what the `Unknown identifier` failures were.
    keep_short = {getattr(d, "gname", None) or d.name_text for d in decls if d in keep}
    keep_short |= {(d.uname or "").split(".")[-1] for d in decls
                   if d in keep and getattr(d, "uname", None)}
    thm_imports = []
    for node in nodes:
        if node.short() not in keep_short:
            continue
        thm_imports.extend(cross_chapter_imports(node, nodes, inline))
    if thm_imports:
        head = thm_imports + head
    text = dedupe_imports("\n".join(head) + "\n\n" + text)
    return text


def dedupe_imports(text):
    """Drop duplicate top-level `import` lines, keeping the first occurrence.

    `build_def_file` prepends `import Mathlib` (plus the upstream Def imports) to
    a body that still carries the source's own `import Mathlib`, so the plain
    concatenation emits it twice.  Imports precede every command in a Lean file,
    so a top-level `import` line is always header material.
    """
    seen, out = set(), []
    for line in text.split("\n"):
        if line.startswith("import ") and line in seen:
            continue
        if line.startswith("import "):
            seen.add(line)
        out.append(line)
    return "\n".join(out)


def module_doc(bt):
    """Text of the leading /-! ... -/ module docstring, if any."""
    head = bt.text[:2000]
    m = re.search(r"/-!(.*?)-\/", head, re.S)
    return m.group(1) if m else ""


def main():
    args = [a for a in sys.argv[1:]]
    defs_only = "--defs-only" in args
    only = [a for a in args if not a.startswith("--")] or WAVE
    graph = load_graph()
    manifest = []
    for leaf in only:
        decls = load_decls(leaf, graph)
        bt = src_byte_text(leaf)
        modns = module_namespace(leaf)
        doc = module_doc(bt)
        defmat, embedded, nodes, inline = classify(decls, doc)
        print(f"== {leaf}: {len(decls)} decls; defmat={len(defmat)} "
              f"embedded={len(embedded)} nodes={len(nodes)} inline={len(inline)}")
        body = build_def_file(bt, leaf, decls, defmat, embedded)
        if body:
            with open(f"{OUT_DEF}/Def_{leaf}.lean", "w", encoding="utf-8") as f:
                f.write(body)
            print(f"   -> Definitions/Def_{leaf}.lean")
        if defs_only:
            continue
        for node in sorted(nodes, key=lambda x: x.s):
            slug = node.uname.replace(".", "_")
            with open(f"{OUT_THM}/Thm_{slug}.lean", "w", encoding="utf-8") as f:
                f.write(build_thm(bt, leaf, decls, node, modns))
            with open(f"{OUT_SOL}/Sol_{slug}.lean", "w", encoding="utf-8") as f:
                f.write(build_sol(bt, leaf, decls, nodes, inline, node, modns))
            index_register(node.uname, slug)
            manifest.append({"leaf": leaf, "name": node.uname,
                             "slug": slug, "plen": node.plen,
                             "ns": node.parent_ns()})
            print(f"   -> node {node.uname} (plen {node.plen})")
    if not defs_only:
        with open(f"{WS}/state/wave_manifest.json", "w") as f:
            json.dump(manifest, f, indent=1)
        print(f"\nmanifest: {len(manifest)} nodes")


if __name__ == "__main__":
    main()