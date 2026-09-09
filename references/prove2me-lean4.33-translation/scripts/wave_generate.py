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
import json
import os
import re
import sys

WS = "/home/leo/prove2me_workspace"
PROJ = "/home/leo/Projects/timepiece"
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


def src_byte_text(leaf):
    with open(f"{PROJ}/BookProof/{leaf}.lean", encoding="utf-8") as f:
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
    the wrong (or no) declaration."""
    pre = bt.slice(0, upto_byte)
    out = []
    in_variable = False
    for line in pre.split("\n"):
        s = line.strip()
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
    with open(f"{PROJ}/BookProof/{leaf}.lean", encoding="utf-8") as f:
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


def imports_for(leaf, node, modns):
    lines = ["import Mathlib", f"import Definitions.Def_{leaf}"]
    for ns in opens_for(node, modns):
        lines.append(f"open {ns}")
    return "\n".join(lines)


def build_thm(bt, leaf, decls, node, modns):
    ctx = structural_preamble(bt, node.s)
    stmt = fmt_name(the_statement(bt, node), node.uname)
    head = [f"-- Generated from {leaf}.lean — theorem {node.uname}\n"]
    head.append(imports_for(leaf, node, modns) + "\n")
    if ctx:
        head.append(ctx + "\n")
    head.append("\n")
    head.append(stmt + " := by sorry\n")
    return "".join(head)


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
    # Strip BookProof.* imports and opens — def bundles only need Mathlib.
    # Cross-chapter dependencies are resolved by the platform's Definitions.
    text = re.sub(r"^import BookProof\.[^\n]*\n", "", text, flags=re.M)
    text = re.sub(r"^open BookProof\.[^\n]*\n", "", text, flags=re.M)
    # Add upstream Def imports for BookProof.ChapterX imports
    src_text = bt.text
    upstream = upstream_def_imports(src_text, leaf)
    if upstream:
        text = "\n".join(upstream) + "\n\n" + text
    return text


def module_doc(bt):
    """Text of the leading /-! ... -/ module docstring, if any."""
    head = bt.text[:2000]
    m = re.search(r"/-!(.*?)-\/", head, re.S)
    return m.group(1) if m else ""


def main():
    only = sys.argv[1:] or WAVE
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
        for node in sorted(nodes, key=lambda x: x.s):
            slug = node.uname.replace(".", "_")
            with open(f"{OUT_THM}/Thm_{slug}.lean", "w", encoding="utf-8") as f:
                f.write(build_thm(bt, leaf, decls, node, modns))
            with open(f"{OUT_SOL}/Sol_{slug}.lean", "w", encoding="utf-8") as f:
                f.write(build_sol(bt, leaf, decls, nodes, inline, node, modns))
            manifest.append({"leaf": leaf, "name": node.uname,
                             "slug": slug, "plen": node.plen,
                             "ns": node.parent_ns()})
            print(f"   -> node {node.uname} (plen {node.plen})")
    with open(f"{WS}/state/wave_manifest.json", "w") as f:
        json.dump(manifest, f, indent=1)
    print(f"\nmanifest: {len(manifest)} nodes")


if __name__ == "__main__":
    main()