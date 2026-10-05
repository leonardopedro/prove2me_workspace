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
WS = (os.environ.get("PROVE2ME_WS")
      or os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PROJ = (os.environ.get("TIMEPIECE_PROJ")
        or os.environ.get("PROVE2ME_PROJ")
        # Same stale-absolute-path trap as the wave entries: a fallback
        # pointing at another machine is silently wrong rather than loud.
        or os.path.join(os.path.dirname(os.path.dirname(
            os.path.abspath(__file__))), "..", "timepiece331"))
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
        # Dense: EVERY byte offset in [0, nbytes] maps to a code-point index. A
        # multi-byte character occupies several byte offsets that the loop above
        # never visits, so those slots kept the list's default 0 -- and
        # `b2c[gap]` returning 0 made `slice()` read from the start of the file,
        # which is how a @[simp] lemma went undetected. Fill the interior of each
        # character as well, so the table is total and monotone.
        nb = len(text.encode("utf-8"))
        self.b2c = [0] * (nb + 1)
        b = 0
        for i, ch in enumerate(text):
            w = len(ch.encode("utf-8"))
            for k in range(w):
                self.b2c[b + k] = i
            b += w
        self.b2c[nb] = len(text)
        self.nbytes = b

    def c2b(self, ci):
        """Code-point index -> byte offset (inverse of b2c)."""
        lo, hi = 0, len(self.b2c)
        while lo < hi:
            mid = (lo + hi) // 2
            if self.b2c[mid] < ci:
                lo = mid + 1
            else:
                hi = mid
        return min(lo, self.nbytes)

    def slice(self, bstart, bend):
        # Clamp: callers legitimately ask for a window past EOF when they are
        # searching for a token, and b2c is a dict lookup, so an out-of-range
        # offset raised IndexError instead of returning the tail.
        # Clamp in BYTE space. `self.nbytes` is the last mapped byte, which is
        # also the max CODE-PONT index -- mixing the two silently returns '' for
        # any offset past the character count, which is how a @[simp] lemma went
        # undetected on a chapter whose text has multi-byte characters.
        lo = max(0, min(bstart, self.nbytes))
        hi = max(lo, min(bend, self.nbytes))
        return self.text[self.b2c[lo]:self.b2c[hi]]


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


def classify(decls, module_doc, bt=None):
    short = {d.short(): d for d in decls}
    defmat = {d for d in decls
              if not d.is_private and d.kind in ("def", "inductive")}
    defmat |= {d for d in decls if d.is_instance}
    # A theorem the bundle's own PROOFS need must be embedded even when it is also
    # a publishable node. Def_Complexification omits `add_re`/`add_im`/`zero_re`
    # ... this way and then fails 12x with `simp made no progress`, because simp
    # has no projection lemma to fire on; the same file compiles in timepiece
    # because everything is in scope there.
    #
    # The vdep closure alone cannot see this: `add_re` is referenced from a PROOF
    # BODY (`simp [add_re]`), which appears in neither typeDeps nor valueDeps. So
    # the closure is extended using identifiers mentioned in the text of each kept
    # declaration's proof, matched against the chapter's theorem names.
    proof_names = {}
    if bt is not None:
        for d in decls:
            try:
                body = bt.slice(d.vs, d.e)
            except Exception:
                continue
            proof_names[id(d)] = set(re.findall(r"(?<![\w.'])([A-Za-z_][\w']*)", body))

    # `@[simp]` is a DEPENDENCY DECLARED IN THE ATTRIBUTE, not in any proof body.
    # `zero_add a := by ext <;> simp` never writes `zero_re`, but simp cannot
    # close `re 0 = 0` without it -- and `declStart` sits AFTER the attribute, so
    # the sketch does not record that the declaration is a simp lemma either.
    # Read the attribute off the source text immediately above the declaration.
    simp_lemmas = set()
    if bt is not None:
        for d in decls:
            if d.kind != "theorem":
                continue
            try:
                # declStart points AT the attribute when there is one, so look
                # forward from it, not backward: reading backwards sees the
                # PREVIOUS declaration's tail (`... := rfl`) and never matches.
                head = bt.slice(d.s, min(d.s + 200, bt.nbytes))
            except Exception:
                continue
            # Not anchored: a declaration's span often begins with its DOCSTRING
            # (`/-- ... -/` then `@[simp] lemma cxMap_one`), so the attribute is
            # not at position 0. Search the window, but require the attribute to be
            # the one belonging to THIS declaration -- i.e. no intervening
            # `lemma|theorem|def|instance` between it and the name.
            m = re.search(r"@\[[^\]]*\bsimp\b[^\]]*\]", head)
            if m:
                between = head[m.end():]
                nm = re.match(r"\s*(?:private\s+|protected\s+|noncomputable\s+)*"
                              r"(?:lemma|theorem|def|abbrev|instance)\s+"
                              + re.escape(d.name_text or "") + r"\b", between)
                if nm:
                    simp_lemmas.add(d)

    def refs(d):
        return proof_names.get(id(d), set())

    # A simp lemma is load-bearing for every `simp` in the bundle, so it is always
    # embedded even if nothing names it.
    embedded = set(simp_lemmas)
    changed = True
    while changed:
        changed = False
        for d in list(defmat) + list(embedded):
            cands = [dep.split(".")[-1] for dep in d.vdeps] + sorted(refs(d))
            for nm in cands:
                c = short.get(nm)
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
            # Per-declaration wrapper (`omit ... in`, `set_option ... in`,
            # `include ... in`): it belongs to its own declaration's span, so
            # hoisting it would attach it to the wrong declaration. Drop it.
            #
            # `open X in` is different: it is the one wrapper whose loss is
            # SILENT and fatal. A file-level `open ContinuousLinearMap in` near
            # the top of `ChapterH8` sits outside every decl span, so dropping it
            # left the stubs unable to see `adjoint` -- 7 theorems failed with
            # `Unknown identifier adjoint`. De-scope it to `open X` instead: that
            # is wider than the original, but the stub is a fresh module whose
            # only consumer is its own theorem, and `drop_shadowing_opens` runs
            # afterwards to undo any shadowing the widening causes.
            mo = re.match(r"^open\s+(scoped\s+)?(.+?)\s+in$", s)
            if mo:
                out.append("open " + (mo.group(1) or "") + mo.group(2))
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


# Must also allow an attribute prefix (`@[simp] theorem ...`) and a `omit … in` /
# `set_option … in` wrapper, or a perfectly ordinary declaration looks like it
# does not start at position 0. That sent `Thm/Sol_..._shiftMap_apply` down the
# re-slice path, which then found the `:=` of its own one-line `:= rfl` body and
# emitted an EMPTY statement -- a stub with no `theorem` in it at all, for any
# attributed single-line declaration.
def find_term_as(text, start):
    """Offset of the `:=` that ends a declaration's TYPE, or None.

    Not simply the first `:=` after the keyword: a named argument inside the type
    looks identical. `theorem t : EssentiallySelfAdjointOn (polyGaussCore (d := 1))
    (hamCore ...) := by ...` has THREE `:=` tokens, and the first belongs to the
    argument. Taking it truncated the type to
    `... (polyGaussCore (d := by sorry`.

    So: skip any `:=` that is a named argument -- preceded by `(`, `,`, `{` or
    whitespace-after-those, with an identifier before it -- and take the first one
    that is not. That is the declaration's own `:=`.
    """
    for m in re.finditer(r":=", text[start:]):
        i = start + m.start()
        before = text[:i].rstrip()
        if before.endswith(("(", ",", "{", "[", "|")):
            continue
        # `f (d := x)`: the token before `:=` is an identifier and the character
        # before that is an opening delimiter.
        name = re.search(r"([A-Za-z_][\w']*)$", before)
        if name and len(before) > len(name.group(1)) and before[-len(name.group(1))-1] in "(,{[|":
            continue
        return i
    return None


DECL_KEYWORD = re.compile(
    r"(?m)^[ \t]*(?:@\[[^\]]*\][ \t]*)?"
    r"(?:(?:omit\s+[^\n]*?|set_option\s+[^\n]*?)\s+in\s+)?"
    r"(?:(?:private|protected|noncomputable|unsafe|partial)\s+)*"
    r"(?:theorem|lemma|def|abbrev)\s")


def the_statement(bt, d):
    # Some decls have declStart pointing just past their docstring, so the slice
    # opens on the docstring's own text preceded by a fragment of whatever came
    # before -- in ChapterYangMillsFriedrichsLimit, `Thm_..._memℓp_one_div_succ`
    # opened with a bare `)` left over from the previous declaration. Anchoring
    # the docstring strip at ^ then could not match, the `)` survived into the
    # emitted statement, and the stub failed with
    # `unexpected token ')'; expected comma`.
    #
    # So: if there is no declaration in the slice, the offsets are pointing at
    # the docstring rather than the `theorem` keyword. Re-slice from the keyword.
    frag = bt.slice(d.s, d.vs)
    # Stale offsets fail two ways, and both must be caught here. When they run past
    # EOF the slice is empty; but they can also land MID-TEXT -- Chapter
    # FriedrichsExtension's stale offset 28883 slices to 'tion is not vacuous: a
    # genuinely unbounded op', i.e. non-empty and useless. A slice that does not
    # begin with a declaration is therefore just as suspect as an empty one.
    lead0 = re.sub(r"^/--(?:.*?)-/\s*", "", frag, flags=re.S)
    if not frag.strip() or not DECL_KEYWORD.match(lead0):
        alt = resolve_by_name(bt, d)
        if alt is not None and DECL_KEYWORD.match(
                re.sub(r"^/--(?:.*?)-/\s*", "", alt[0], flags=re.S)):
            return alt[0]
    # The keyword has to be the FIRST thing in the slice, not merely present:
    # a docstring's prose can contain the word "theorem", and matching inside it
    # made this guard silently pass. Only a match at position 0 means the
    # offsets really do point at the declaration.
    # A span that begins with its own `/-- ... -/` docstring is the NORMAL case,
    # not the broken one. Testing position 0 with DECL_KEYWORD alone sent every
    # documented declaration down the re-slice path, where the search ran past
    # the slice and returned None -- so the statement came out empty and the stub
    # was just `:= by sorry`. See Thm_..._qgFiberSum_nonneg_form.
    lead = re.sub(r"^/--(?:.*?)-/\s*", "", frag, flags=re.S)
    if not DECL_KEYWORD.match(lead):
        # Offsets point at the docstring, not the `theorem` keyword. Find the
        # keyword in the wider source and re-slice from there, so the leading
        # fragment is dropped instead of being emitted as the first line.
        # d.vs + 4000 can run past the end of the file, and slice() indexes
        # rather than clamping.
        m = DECL_KEYWORD.search(bt.slice(d.s, bt.nbytes))
        if m is None:
            return frag
        frag = bt.slice(d.s + m.start(), d.vs)
    # `valStart` is the offset of `:=`, not the end of the type. A statement like
    # `theorem t : Memℓp f 2 := by` has valStart pointing at the `:=`, so slicing
    # to it drops the trailing `2` and the emitted statement becomes
    # `Memℓp f` -- a different, arity-wrong proposition that fails with
    # `type expected, got (Memℓp fun n => ...)`. Extend to the `:=` ourselves.
    # Ask for everything to EOF rather than a fixed window: `slice` takes BYTE
    # offsets and maps them through a char-index table, so a guessed window can
    # land somewhere unhelpful, and the statement is only a few lines long.
    # `valStart` is not reliably the `:=` token: in
    # ChapterNavierStokesFockCanonical it points at col 66 of the statement's
    # own body, mid-expression. So do not trust it -- search forward from the
    # declaration for the first `:=` that terminates the TYPE. Anchoring to a
    # line that starts with `:=` is not enough either (a one-line declaration
    # puts it mid-line), and searching blindly finds the `:= sorry` we are about
    # to append, which truncates the type into `( := by sorry`. Take the first
    # `:=` after the declaration keyword, which is by construction the type's.
    body = bt.slice(d.s, bt.nbytes)
    km = DECL_KEYWORD.match(body) or DECL_KEYWORD.search(body)
    if km is not None:
        m2 = find_term_as(body, km.end())
        if m2 is not None:
            frag = body[:m2]
    frag = re.sub(r"^/--(?:.*?)-/\s*", "", frag, flags=re.S).rstrip()
    # The re-slice above can land in the middle of a docstring, leaving its tail
    # (`... support. -/`) as the first line of the statement. Drop any leading
    # text up to and including a docstring closer.
    if not DECL_KEYWORD.match(frag):
        frag = re.sub(r"^(?:.|\n)*?-/\s*", "", frag, count=1, flags=re.S).lstrip()
    if not DECL_KEYWORD.match(frag):
        return frag
    frag = re.sub(r":=\s*$", "", frag).rstrip()
    return frag


def resolve_by_name(bt, d):
    """Re-derive a declaration's span from the source TEXT when offsets are stale.

    A sketch cache older than its chapter records byte offsets that no longer index
    the file, so `bt.slice(d.s, d.vs)` returns '' and the stub comes out as a bare
    `:= by sorry` (PIPELINE_PLAN 2.8b: 361 of 777 caches are stale). Re-extraction
    is not available -- `extract_sketch_info.lean` blows its 900s timeout on most of
    those chapters -- so locate the declaration textually instead.

    `d.name_text` and the graph's `startLine` are both independent of the byte
    offsets, so they survive: start at the recorded line (with slack either way in
    case that drifted too) and take the first line matching the declaration, then
    span to the next top-level declaration.

    Returns (statement, proof), or None when the name cannot be located.
    """
    name = getattr(d, "name_text", None)
    if not name:
        return None
    lines = bt.text.split("\n")
    pat = re.compile(r"^\s*(?:@\[[^\]]*\][ \t]*)?"
                     r"(?:(?:private|protected|noncomputable|unsafe|partial)\s+)*"
                     r"(?:theorem|lemma|def|abbrev)\s+" + re.escape(name) + r"\b")
    start = None
    base = max(0, (getattr(d, "sl", 1) or 1) - 1)
    # `startLine` may point at the declaration's DOCSTRING rather than its keyword
    # (ChapterFriedrichsExtension: startLine 586, `theorem` on 592), so the forward
    # window has to cover a multi-line docstring. 60 covers every docstring seen;
    # the pattern requires the exact name, so a wide window costs nothing.
    order = [base - k for k in range(0, 8)] + [base + k for k in range(1, 60)]
    for cand in order + list(range(len(lines))):
        if 0 <= cand < len(lines) and pat.match(lines[cand]):
            start = cand
            break
    if start is None:
        return None
    end = len(lines)
    for j in range(start + 1, len(lines)):
        if re.match(r"^\s*(?:@\[|private\s|protected\s|noncomputable\s|theorem\s|"
                    r"lemma\s|def\s|abbrev\s|instance\s|structure\s|"
                    r"end\b|section\b|namespace\b|/-)", lines[j]):
            end = j
            break
    body = "\n".join(lines[start:end]).rstrip()
    km = DECL_KEYWORD.match(body)
    cut = find_term_as(body, km.end()) if km else None
    if cut is None:
        return body, ""
    return body[:cut].rstrip(), body[cut + 2:].strip()


def the_proof(bt, d):
    """Return (body, mode) where mode is 'tactic' when the source proof starts
    with `by` (a tactic block) and 'term' when it is a plain term (`:= rfl`,
    `:= ⟨a, b⟩`, `:= someTheorem x y`, …).  Tactic bodies keep their source
    indentation; term bodies are emitted directly after `:=` (never under a
    `by` block, which cannot contain `⟨…⟩` constructor syntax)."""
    frag = bt.slice(d.vs, d.e)
    if not frag.strip():
        alt = resolve_by_name(bt, d)
        frag = alt[1] if alt is not None else frag
    if frag.strip() and not re.match(r"^\s*(?:by\b|\S)", frag):
        pass
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
        # `[A-Za-z0-9_.']` is ASCII-only, and timepiece uses non-ASCII identifiers
    # freely (memℓp_one_div_succ, Memℓp). Matching only `theorem mem` and
    # splicing left the tail glued onto the new name, so every such theorem was
    # emitted as `...memℓp_one_div_succℓp_one_div_succ` -- a name that does not
    # exist, hence never provable. Consume the whole identifier instead.
    r"(?:theorem|lemma)\s+[^\s(){}\[\]:;]+",
        stmt, flags=re.S)
    if not m:
        return stmt
    return stmt[:m.start()] + f"theorem {newname}" + stmt[m.end():]


_THM_INDEX = None
_NAME_OWNER = None
_NS_OWNER = None
_NS_TO_OWNER = None
_BUNDLE_NS = None
_SOURCE_NS = None


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
    # Match import BookProof.<Name> (direct, no Chapter prefix).
    #
    # The bundle for such a module is NOT always Def_Chapter<Name>: ChapterA1b
    # imports `BookProof.Complexification`, whose bundle is Def_Complexification,
    # so building Def_ChapterComplexification found nothing and the import was
    # dropped. The result was `Function expected at Cx ... but this term has type
    # ?m.3` on a bundle that references Cx 20-odd times. Try both spellings.
    for m in re.finditer(r"^import BookProof\.([A-Z][A-Za-z0-9]*)", source_text, re.M):
        name = m.group(1)
        if name in seen:
            continue
        seen.add(name)
        for cand in (f"Def_Chapter{name}.lean", f"Def_{name}.lean"):
            if os.path.exists(f"{OUT_DEF}/{cand}"):
                imports.append(f"import Definitions.{cand[:-len('.lean')]}")
                break
    # Finally: every `open BookProof.X` needs the bundle that DECLARES X in scope,
    # or Lean answers `unknown namespace`. The platform index is authoritative for
    # the namespace -> bundle mapping. 23 of the 55 candidate bundles failed this
    # way -- including ones whose own source DID import the provider, because the
    # source's `import BookProof.X` is stripped above and only re-added when a
    # matching Def file happened to exist at generation time.
    # Scan EVERY `open` line and keep the BookProof tokens, rather than requiring
    # the line to consist only of them. `open Filter Topology
    # BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness` is an ordinary
    # source line; anchoring on "^open BookProof" missed all of them, which is why
    # Def_ChapterAttentionEntropy shipped with no provider import at all.
    opens = set()
    for m in re.finditer(r"(?m)^open\s+(?!scoped\b)([^\n=]*)$", source_text):
        for tok in m.group(1).split():
            if tok.startswith("BookProof."):
                opens.add(tok)
    for ns in sorted(opens):
        owner = owner_of_namespace(ns)
        if not owner:
            continue
        mod = owner if owner.startswith("Def_") else f"Def_{owner}"
        imp = f"import Definitions.{mod}"
        if imp not in imports:
            imports.append(imp)
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
    # Prefer an EXACT match in real bundle text over the platform index.
    #
    # The index is not authoritative here: `namespace_owner` is empty for a chapter
    # published after the last index refresh, so `BookProof.ChapterFreeFieldBorn`
    # fell through to the longest-prefix branch, which matched the bare `BookProof`
    # entry and returned `ChapterA4`. The consuming bundle then imported A4 instead
    # of FreeFieldBorn and died on `unknown namespace BookProof.ChapterFreeFieldBorn`.
    table = _bundle_text_namespaces()
    if ns in table:
        return table[ns]
    index = namespace_to_owner()
    if ns in index:
        return index[ns]
    parts = ns.split(".")
    for k in range(len(parts) - 1, 0, -1):
        prefix = ".".join(parts[:k])
        if prefix in table:
            return table[prefix]
    for k in range(len(parts) - 1, 0, -1):
        prefix = ".".join(parts[:k])
        if prefix in index:
            return index[prefix]
    return None


def _bundle_text_namespaces():
    """namespace -> bundle, scanned from the actual bundle files.

    Published text first (authoritative for what the platform has), then the local
    `Definitions/` tree (authoritative for what we are about to publish).
    """
    global _BUNDLE_NS
    if _BUNDLE_NS is not None:
        return _BUNDLE_NS
    _BUNDLE_NS = {}
    for root in (f"{WS}/state/published_bundles", OUT_DEF):
        if not os.path.isdir(root):
            continue
        for f in os.listdir(root):
            if not (f.startswith("Def_") and f.endswith(".lean")):
                continue
            try:
                t = open(f"{root}/{f}", encoding="utf-8", errors="ignore").read()
            except OSError:
                continue
            ch = f[4:-5]
            for ns in declared_namespaces(t):
                _BUNDLE_NS.setdefault(ns, ch)
    return _BUNDLE_NS


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
    # The stub's OWN module namespace must be open, or the statement's unqualified
    # names do not resolve. `opens_for` only returns the node's PARENT namespace,
    # which for a top-level theorem is the module namespace -- but nothing emitted
    # it, so Thm_BookProof_GroupAverage_UnitaryRep_avgProj_mem opened only its
    # dependencies and then failed `Function expected at UnitaryRep`.
    if modns and f"open {modns}" not in opens:
        opens.append(f"open {modns}")
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


def scoped_opens_before(pre):
    """The contiguous run of `open ... in` lines ending the preamble.

    `structural_preamble` deliberately does not hoist per-declaration wrappers
    ending in `in`, because Stage 2's decl span is supposed to contain them. But
    the span starts at the docstring, so an `open X in` written ABOVE the
    docstring falls in the gap and is lost from the stub -- and the stub then
    fails with `Unknown identifier` for every name that open provided.
    `ChapterH8` lost all five of its `open ContinuousLinearMap in` lines this
    way, which is why its `adjoint_aeval` stub could not see `adjoint`.

    So return that trailing run and re-attach it to the declaration it scopes,
    rather than hoisting every `... in` in the file.
    """
    lines = pre.rstrip("\n").split("\n")
    # Trailing blank lines are padding, not part of the run.
    while lines and lines[-1].strip() == "":
        lines.pop()
    out = []
    for ln in reversed(lines):
        st = ln.strip()
        if st.startswith("open ") and st.endswith(" in"):
            out.append(ln)
            continue
        if st == "":
            # A blank line inside the run would end it, but allow blanks that
            # merely pad the block by looking one further back first.
            if out:
                out.append(ln)
                continue
        break
    return list(reversed(out))


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
        # Read the RAW text before the node: `structural_preamble` has already
        # stripped the `open ... in` lines from `ctx`, so scanning `ctx` cannot
        # recover them.
        scoped = scoped_opens_before(bt.slice(0, node.s).decode("utf-8", "ignore"))
        head.append("\n".join(scoped) + "\n" if scoped else "")
        head.append(ctx + "\n")
    head.append("\n")
    # PIPELINE_PLAN 6.1: the server rejects `'` in a theorem_name --
    # "theorem_name must be a valid Lean identifier". Observed directly:
    # `modeShift_shift_ne'` was refused while its eight siblings published.
    # Rewrite primes to `_prime`, as the plan prescribes.
    stmt = re.sub(r"^(theorem\s+)([A-Za-z_][\w.]*?')",
                  lambda m: m.group(1) + re.sub(r"'", "_prime", m.group(2)),
                  stmt, flags=re.M)
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
    # Both filters run LAST: the block above can still add `open` lines, and a
    # filter that runs before it misses everything it adds.
    text = drop_undeclared_opens(text, leaf)
    text = drop_shadowing_opens(text, text)
    return text


def drop_rebound_variables(text, stmt):
    """Drop a `variable` line for a name the declaration binds itself.

    A chapter-level `variable {d : ℕ}` is right for most theorems in the file,
    but a theorem that binds `d` at a DIFFERENT type -- `(d : NSTruncation n)` --
    then gets the chapter's implicit `d` applied first and fails with
    `Application type mismatch: The argument d has type NSTruncation n but is
    expected to have type ℕ`. Identical-block dedupe does not catch it, because
    the two declarations are not identical.

    Only the declaration's own binder names count, so this keys off the `sig`
    (everything before `:=`).
    """
    if not stmt:
        return text
    cut = stmt.index("theorem") if "theorem" in stmt else 0
    decl = stmt[cut:]
    sig = decl.split(":=", 1)[0]
    bound = set(re.findall(r"[({\[,|:]\s*([A-Za-z_][\w']*)\s*(?::|∈)", sig))
    bound |= set(re.findall(r"^\s*[|⟨]?\s*([A-Za-z_][\w']*)\s*(?::|∈)", sig, re.M))
    if not bound:
        return text
    out, dropped = [], []
    lines = text.split("\n")
    i = 0
    while i < len(lines):
        ln = lines[i]
        st = ln.strip()
        if st.startswith("variable "):
            block = [ln]
            j = i + 1
            while (j < len(lines) and lines[j][:1].isspace() and lines[j].strip()
                   and not lines[j].strip().startswith(("theorem", "lemma", "def",
                                                          "abbrev", "instance", "structure",
                                                          "end", "namespace", "open", "import"))):
                block.append(lines[j]); j += 1
            names = set(re.findall(r"([A-Za-z_][\w']*)\s*:", " ".join(block)))
            if names & bound:
                dropped.append(sorted(names & bound))
                i = j
                continue
            out.extend(block); i = j
            continue
        out.append(ln); i += 1
    for d in dropped:
        print(f"  WARNING dropped `variable` for {d}: the declaration binds it "
              f"itself at a different type", file=sys.stderr)
    return "\n".join(out)


def declared_namespaces(text):
    """Fully-qualified namespaces a Lean file declares, tracking nesting.

    A flat namespace scan misses nested ones:
    `namespace BookProof` followed by `namespace ChapterA` then
    `namespace System` declares `BookProof.ChapterA.System`, which the flat scan
    records as the bare `System` -- so a consumer's
    `open BookProof.ChapterA.System` looks undeclared and the open is deleted,
    giving `Unknown identifier` for every name it would have brought into scope.
    `section X` is deliberately NOT pushed: a section introduces no namespace.

    Comment text is blanked first so a docstring mentioning `namespace Foo` does
    not push a phantom frame.
    """
    text = strip_lean_comments(text)
    stack, out = [], set()
    for ln in text.split("\n"):
        st = ln.strip()
        m = re.match(r"^namespace\s+([\w.]+)", st)
        if m:
            name = m.group(1)
            full = name if name.startswith("BookProof") else ".".join(
                stack + [name]) if stack else name
            out.add(full)
            stack.append(name)
            continue
        m = re.match(r"^end\s+([\w.]+)", st)
        if m:
            if stack:
                stack.pop()
    return out


def strip_lean_comments(text):
    """Blank out docstrings and line comments, preserving line structure.

    Used to keep identifier heuristics off prose. Replaces comment characters
    with spaces instead of deleting them so that `stmt` offsets still line up and
    a `\n`-based scan sees the same number of lines.
    """
    out = list(text)
    i, n = 0, len(text)
    def blank(a, b):
        for k in range(a, min(b, n)):
            if out[k] != "\n":
                out[k] = " "
    while i < n:
        if text.startswith("/-", i):
            depth, j = 0, i
            while j < n:
                if text.startswith("/-", j):
                    depth += 1; j += 2
                elif text.startswith("-/", j):
                    depth -= 1; j += 2
                    if depth == 0:
                        break
                else:
                    j += 1
            blank(i, j); i = j
        elif text.startswith("--", i):
            j = text.find("\n", i)
            j = n if j < 0 else j
            blank(i, j); i = j
        else:
            i += 1
    return "".join(out)


def drop_shadowing_opens(text, stmt=None):
    """Drop an `open NS` whose last segment shadows a name the statement uses.

    A structure and a namespace can share a name. `ChapterNavierStokesShiftHamiltonian`
    declares `structure ShiftData (ι : Type*)` inside
    `namespace BookProof.NavierStokesFlow.ShiftHamiltonian`, and also a nested
    `namespace ...ShiftHamiltonian.ShiftData` holding `hasSum_commForm`. Opening
    the nested one makes the bare name `ShiftData` resolve to the NAMESPACE
    rather than the structure, so `ShiftData ι` fails with `Function expected at
    ShiftData`. Opening the parent keeps the structure usable and still brings
    the nested declarations into scope.
    """
    if not stmt:
        return text
    # `stmt` here is the WHOLE assembled file, not just the declaration: the
    # application that matters is usually in a `variable` line
    # (`variable {ι : Type*} (S : ShiftData ι)`), which sits outside the
    # declaration itself.
    # Only an APPLIED name shadows usefully: the failure is `ShiftData ι`
    # where `ShiftData` is a structure. A bare mention of the name is harmless,
    # so matching on application avoids rewriting legitimate opens.
    # Match only CODE. The shadowing test is `last <arg>`, and a module docstring
    # is full of prose like "`ChapterA3j` shows ...", which matched and rewrote
    # `open BookProof.ChapterA3j` to `open BookProof` -- dropping the bare-name
    # scope the bundle body needs and producing `Unknown identifier` en masse.
    stmt = strip_lean_comments(stmt)
    out, rewritten = [], []
    for ln in text.split("\n"):
        st = ln.strip()
        if st.startswith("open BookProof."):
            names = st.split()[1:]
            keep, changed = [], False
            for one in names:
                last = one.split(".")[-1]
                applied = re.search(r"(?<![.\w])" + re.escape(last) + r"\s+\S", stmt)
                if applied:
                    parent = ".".join(one.split(".")[:-1])
                    if parent:
                        keep.append(parent)
                        changed = True
                        continue
                keep.append(one)
            if changed:
                rewritten.append(st)
                ln = ln.replace(st, "open " + " ".join(keep))
        out.append(ln)
    for r in rewritten:
        print(f"  WARNING re-opened the parent of a shadowing namespace from `{r}`",
              file=sys.stderr)
    return "\n".join(out)


def add_missing_namespace_imports(text):
    """Import the def bundle behind every `open BookProof.X`, or drop the open.

    `drop_undeclared_opens` only asked whether *some* bundle declares the
    namespace. That is the wrong question: `BookProof.QgHermiteOscillator` is
    declared by Def_ChapterQgHermiteOscillatorEsa, so the `open` survived --
    but Sol_..._harmCore_symmetricOn imports only Def_ChapterSqSumFarisLavine,
    so the namespace is not in scope and Lean reports `unknown namespace`. The
    generator copied eight such `open` lines from the source file header
    without carrying the imports that back them.

    Importing is the better repair than dropping the open: the proof body may
    genuinely use names from that namespace, and a bare `open` is only noise
    when nothing references it. So add the import when the owning bundle is
    published, and leave the existing behaviour to `drop_undeclared_opens` for
    namespaces nothing declares at all.
    """
    owner = namespace_to_owner()
    if not owner:
        return text
    have = set(re.findall(r"(?m)^import Definitions\.(Def_\S+)", text))
    wanted = {}
    for ln in text.split("\n"):
        st = ln.strip()
        if not st.startswith("open BookProof."):
            continue
        for one in st.split()[1:]:
            if not one.startswith("BookProof."):
                continue
            b = owner.get(one) or owner_of_namespace(one)
            if b:
                # The index records the chapter name; the module is Def_<chapter>.
                mod = b if b.startswith("Def_") else f"Def_{b}"
                if mod not in have:
                    wanted[mod] = one
    if not wanted:
        return text
    lines = text.split("\n")
    # Imports must precede every `open`, or Lean rejects them with
    # "invalid 'import' command, it must be used at the beginning".
    at = max((i for i, l in enumerate(lines) if l.startswith("import ")), default=0)
    adds = [f"import Definitions.{b}" for b in sorted(wanted)]
    lines[at + 1:at + 1] = adds
    for b, ns in sorted(wanted.items()):
        print(f"  WARNING added `import Definitions.{b}`: it declares "
              f"`{ns}`, which was opened but never imported", file=sys.stderr)
    return "\n".join(lines)


def disambiguate_names(text, leaf, ns=None):
    """Qualify a name that two imported def bundles both declare.

    `BookProof.QgOuterFock.sqSumPoly` and `BookProof.SqSumFarisLavine.sqSumPoly`
    are distinct definitions with the same base name. Once a solution imports
    both bundles -- which `add_missing_namespace_imports` does whenever the
    source file's `open` lines reach into both chapters -- every bare
    `sqSumPoly` becomes `Ambiguous term`. The fix belongs in the generator, not
    per file: qualify the occurrence with the declaring namespace of the
    theorem being proved, which is the one whose meaning the proof intends.

    Only names that (a) are declared by more than one *imported* bundle and
    (b) occur bare in the proof body are touched, and the declaration itself is
    never rewritten.
    """
    mods = re.findall(r"(?m)^import Definitions\.(Def_\S+)", text)
    if len(mods) < 2:
        return text
    try:
        idx = json.load(open(f"{WS}/state/defs_index.json"))["bundles"]
    except Exception:
        return text
    owners = {}
    for m in mods:
        for n in (idx.get(m, {}).get("names") or []):
            owners.setdefault(n, set()).add(m)
    # The index only carries names for bundles whose published text still has
    # its declarations. Once a theorem is Proved the platform withholds them, so
    # a fully published bundle indexes zero names while Lean still sees all of
    # them. Fall back to the declaration sites for anything the index missed.
    DECL = re.compile(r"(?m)^\s*(?:noncomputable\s+)?(?:private\s+)?"
                      r"(?:def|abbrev|theorem|lemma)\s+([A-Za-z_][\w']*)")
    for m in mods:
        src = f"{WS}/state/published_bundles/{m}.lean"
        if not os.path.exists(src):
            src = f"{WS}/Definitions/{m}.lean"
        if not os.path.exists(src):
            continue
        for n in DECL.findall(open(src, errors="ignore").read()):
            owners.setdefault(n, set()).add(m)
    dupes = {n for n, ms in owners.items() if len(ms) > 1}
    if not dupes:
        return text
    if not ns:
        # The stub declares `theorem solution : ...` -- that is the submission
        # format from references/prove.md, not the target's name, so parsing it
        # yields the namespace `solution` and qualifies everything wrongly. Fall
        # back to the fully-dotted form only if one is actually present.
        m = re.search(r"(?m)^[ \t]*theorem\s+([\w.]+\.[\w']+)\s*[:(]", text)
        if not m:
            return text
        ns = m.group(1).rsplit(".", 1)[0]
    head, sep, body = text.partition(":= by")
    if not sep:
        return text
    changed = []
    for n in sorted(dupes, key=len, reverse=True):
        # already qualified, or not bare: leave it alone
        pat = re.compile(rf"(?<![\w.]){re.escape(n)}\b")
        if not pat.search(body):
            continue
        body = pat.sub(f"{ns}.{n}", body)
        changed.append(n)
    for n in changed:
        print(f"  WARNING qualified `{n}` as `{ns}.{n}`: declared by more than "
              f"one imported bundle", file=sys.stderr)
    return head + sep + body


def drop_undeclared_opens(text, leaf=None):
    """Remove `open BookProof.X` lines for namespaces no bundle declares.

    A `section IsShiftInvert` nested inside `namespace
    BookProof.HashimotoShiftInvert` creates no namespace of that name, so
    opening it is `unknown namespace` -- and nothing can import it away. The
    generator was inventing these from the node's own dotted path.

    Scoped to `BookProof.` on purpose: our namespaces are the platform index's
    business and it is authoritative for them, but Mathlib's are not indexed at
    all, so a blanket filter would be wrong.

    Applied to both theorem stubs and solutions -- the solution side had the
    identical defect, and the uploader's preflight gate refused three otherwise
    submittable solutions over it.
    """
    known = set(namespace_to_owner())
    # Namespaces declared by LOCAL bundles count as declared. The platform index
    # only knows chapters that are PUBLISHED, so for an unpublished chapter
    # `BookProof.GroupAverage` looks undeclared and this filter deletes the open --
    # including the module's own namespace, which is the one open a stub cannot do
    # without. The stub is going to be published, so its own chapter's namespaces
    # are legitimate.
    for f in os.listdir(OUT_DEF):
        if not (f.startswith("Def_") and f.endswith(".lean")):
            continue
        try:
            t = open(f"{OUT_DEF}/{f}", encoding="utf-8", errors="ignore").read()
        except OSError:
            continue
        known |= declared_namespaces(t)
    # ALSO trust the namespaces of already-PUBLISHED bundles, read from the live
    # platform text rather than from the index. `namespace_owner` is empty for a
    # chapter whose namespace only became real at its most recent publication, so
    # `BookProof.ChapterFreeFieldBornSignGauge` looked undeclared and the source's
    # `open BookProof.ChapterFreeFieldBornSignGauge` was deleted -- leaving the
    # consuming bundle with `Unknown identifier signFlip`.
    for f in os.listdir(f"{WS}/state/published_bundles"):
        if not (f.startswith("Def_") and f.endswith(".lean")):
            continue
        try:
            t = open(f"{WS}/state/published_bundles/{f}", encoding="utf-8",
                     errors="ignore").read()
        except OSError:
            continue
        known.update(re.findall(r"(?m)^namespace\s+([\w.]+)", t))
    # ALSO trust the SOURCE tree. Every chapter source is present up front, so a
    # namespace is declared the moment we know which chapter owns it -- whereas
    # reading only the generated bundles makes the output depend on GENERATION
    # ORDER: a chapter generated before its provider's bundle existed had the
    # open silently deleted, and nothing regenerated it later. That produced
    # `Unknown identifier hermBasisN` on 26 bundles at once (the source opened
    # `BookProof.QuadFockEsa`, declared by an already-published chapter, and the
    # bundle had lost the open). Reading the sources makes generation
    # order-independent and idempotent.
    global _SOURCE_NS
    if _SOURCE_NS is None:
        _SOURCE_NS = set()
        bp = f"{PROJ}/BookProof"
        for root, _dirs, files in os.walk(bp):
            for f in files:
                if not f.endswith(".lean"):
                    continue
                try:
                    t = open(os.path.join(root, f), encoding="utf-8",
                             errors="ignore").read()
                except OSError:
                    continue
                _SOURCE_NS |= declared_namespaces(t)
    known |= _SOURCE_NS
    out, dropped = [], []
    for ln in text.split("\n"):
        st = ln.strip()
        if st.startswith("open BookProof."):
            toks = st.split()
            bad = [one for one in toks[1:]
                   if one.startswith("BookProof.") and one not in known]
            good = [one for one in toks[1:]
                    if one.startswith("BookProof.") and one in known]
            if bad:
                dropped.extend(bad)
                # Keep the namespaces that ARE declared. Dropping the whole line
                # when only one of several is undeclared took valid opens with it:
                # `open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder`
                # lost ChapterSoftmaxSharpness (whose bundle exists) because
                # ChapterSoftmaxOrder had none -- 140 bundles were affected.
                if not good:
                    continue
                # Preserve a trailing scope keyword. `open A B in` is a SCOPED
                # open; rewriting it to `open A B` widens it to the whole file
                # and silently changes which names resolve where.
                tail = ""
                if toks[-1] in ("in", "in",):
                    tail = " in"
                out.append("open " + " ".join(good) + tail)
                continue
        elif st.startswith("open ") and "BookProof." not in st:
            # Qualify a bare namespace with `BookProof.` when that namespace
            # exists. `open LpNat FarisLavine IkebeKato ThreeComponent` fails with
            # `unknown namespace 'FarisLavine'`: Lean resolves a bare `open`
            # against root namespaces only, and these are all `BookProof.*`.
            toks = st.split()
            fixed = [toks[0]]
            for t in toks[1:]:
                if not t.startswith("BookProof.") and f"BookProof.{t}" in known:
                    fixed.append("BookProof." + t)
                else:
                    fixed.append(t)
            if fixed != toks:
                ln = ln.replace(st, " ".join(fixed))
        out.append(ln)
    for one in dropped:
        print(f"  WARNING dropped `open {one}`: no bundle declares it",
              file=sys.stderr)
    return "\n".join(out)


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
    # The `variable` declarations, bounded to this theorem. Same omission the
    # theorem stubs had: `Sol_...IsShiftInvert_mem` states
    # `theorem solution {A : Dom ->L[] F} ... : R u ∈ Dom`, and `Dom` is only
    # ever bound by a `variable` in the source, so the server rejected it with
    # `Unknown identifier 'Dom'` -- and explicitly noted it cannot be auto-bound
    # because the platform runs with `autoImplicit := false`. build_sol never
    # emitted them at all.
    ns_vars = extract_namespace_variables(bt, getattr(node, "sl", None))
    if ns_vars:
        parts.append("\n" + ns_vars + "\n")
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
    # Same undeclared-namespace filter as the theorem stubs. Without it the
    # uploader's preflight gate refused three otherwise-submittable solutions
    # over `open BookProof.HashimotoShiftInvert.IsShiftInvert`, which nothing
    # declares -- a `section` is not a namespace.
    text = drop_undeclared_opens("".join(parts), leaf)
    return text


def build_def_file(bt, leaf, decls, defmat, embedded):
    keep = defmat | embedded
    if not keep:
        # A chapter whose declarations are ALL theorems has nothing to publish as
        # a Definition body -- but other chapters `open BookProof.<leaf>`, and that
        # open fails with `unknown namespace` unless SOME bundle declares the
        # namespace and imports its prerequisites. `ChapterFreeFieldBornCont` (5
        # theorems, 0 definitions) blocked 6 downstream chapters this way. Emit a
        # namespace anchor: the upstream Def imports plus an empty namespace.
        return build_ns_anchor(bt, leaf)

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
    # Def bundles need the same two open filters the stubs got. Without them a
    # batch of 29 regenerated bundles was rejected server-side on
    # `unknown namespace` / `Unknown identifier`, from the same shadowing and
    # bare-name problems already fixed in build_thm and build_sol.
    text = drop_undeclared_opens(text, leaf)
    text = drop_shadowing_opens(text, text)
    return text


def build_ns_anchor(bt, leaf):
    """Imports + empty namespace, so `open BookProof.<leaf>` resolves."""
    ns = module_namespace(leaf) or f"BookProof.{leaf}"
    upstream = upstream_def_imports(bt.text, leaf)
    head = ["import Mathlib"]
    if upstream:
        head = upstream + head
    body = dedupe_imports("\n".join(head) + "\n\n")
    doc = module_doc(bt)
    if doc.strip():
        # AFTER the imports: Lean rejects `invalid 'import' command, it must be
        # used at the top of the file` when a docstring precedes them.
        body += f"/-!\n{doc.strip()}\n-/\n"
    body += f"namespace {ns}\n\nend {ns}\n"
    body = drop_undeclared_opens(body)
    return body


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
        defmat, embedded, nodes, inline = classify(decls, doc, bt)
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