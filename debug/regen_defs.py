#!/usr/bin/env python3
"""Improved def-bundle regeneration for the wave (self-contained bundles).

WHY
---
The old generator (scripts/wave_generate.py) emits, for each wave chapter, a
Definitions/Def_ChapterX.lean that begins with

    import Definitions.Def_ChapterH4        # cross-bundle dependency
    import Mathlib
    ...

The platform compiles each def bundle in an environment with ONLY Mathlib plus
Definitions that were *already published*.  H4 / HermiteProductCore /
FriedrichsExtension were never published and are not in the wave, so those
`import Definitions.Def_X` lines fail on the platform with "No such definition
exists in this Lean environment".  The thm/sol stubs then fail too (they import
the def bundle).

THE FIX
-------
Regenerate the bundles to be fully self-contained: `import Mathlib` only, with
every cross-chapter declaration that the bundle's defs (and the wave's thm
statements and sol proofs for that chapter) reference INLINED into the bundle
under its ORIGINAL namespace.  Inlining uses *skeleton subtraction* per source
chapter (keep all inter-declaration text — `variable` blocks, `open` lines,
namespace transitions, `section`s — and delete only the unselected declaration
spans), so the inlined decls keep the exact context they need to elaborate.

* Helper theorems referenced by def bodies / sol proofs are inlined with their
  REAL proofs (the closure follows type+value deps for theorems too), so the
  bundle stays sorry-free like the already-published bundles.
* The leaf's own *node* theorems (uploaded as separate Thm/Sol nodes) are NOT
  inlined — only the declarations the wave statements/proofs need.
* Chapter blocks are emitted in topological order of namespace references.

Safety
------
* Only regenerates bundles listed on the command line (`--auto` picks the ones
  that are broken: they import a non-wave Definitions bundle or fail to compile
  Mathlib-only).  Already-fixed Definitions are never rewritten.
* Use `--out DIR` to redirect output for inspection (never touches Definitions/).

USAGE
-----
    python3 debug/regen_defs.py --check            # report broken bundles
    python3 debug/regen_defs.py --auto             # regenerate broken ones
    python3 debug/regen_defs.py ChapterSirkEndToEnd   # specific chapter
    python3 debug/regen_defs.py --all --out /tmp/x # full run to a folder
"""
import importlib.util
import json
import os
import re
import sys

WS = "/home/leo/prove2me_workspace"
SKETCH_DIR = f"{WS}/state/sketch"
DEF_DIR = f"{WS}/Definitions"

WAVE = json.load(open(f"{WS}/pipeline/wave_upload.json"))
WAVE_DEFS = set(WAVE["defs"].keys())
WAVE_THMS = WAVE["thms"]

spec = importlib.util.spec_from_file_location("wg", f"{WS}/scripts/wave_generate.py")
wg = importlib.util.module_from_spec(spec)
spec.loader.exec_module(wg)

STOPWORDS = set("""
theorem lemma def abbrev inductive instance namespace open import sorry end by
have show exact rw simp apply exacts convert simpa refine intro cases obtain
subst specialize revert induction constructor left right omega linarith ring
ring_nf positivity nlinarith norm_num field_simp unfold dsimp change calc fun
hx in h with and or not forall exists if then else let match Classical
propext Quot Sound choice noncomputable section variable include set_option
universe attribute local notation scoped infix postfix prefix protected
private unsafe partial mut where all_goals try solve done assumption
contradiction trivial aesop bv_omega polyrith gcongr
""".split())


def load_index():
    graph = wg.load_graph()
    idx = {}
    for fn in os.listdir(SKETCH_DIR):
        if not fn.endswith(".jsonl"):
            continue
        leaf = fn[len("sketch_"):-len(".jsonl")]
        try:
            decls = wg.load_decls(leaf, graph)
        except Exception:
            continue
        for d in decls:
            idx.setdefault(d.name_text, []).append(d)
    return idx, graph


IDX, GRAPH = load_index()


def defining_chapters(name):
    return [d.leaf for d in IDX.get(name, [])]


def gname_index():
    """fully-qualified name -> (leaf, short name).  Multiple chapters may
    define the same short name in different namespaces; the gname is the
    unique key (matches how deps are recorded in the sketch)."""
    gidx = {}
    for leaf in set(d.leaf for ds in IDX.values() for d in ds):
        try:
            decls = wg.load_decls(leaf, GRAPH)
        except Exception:
            continue
        for d in decls:
            gidx.setdefault(d.gname, (leaf, d.name_text))
    return gidx


GIDX = gname_index()


def gname_leaf(gname):
    """Resolve a fully-qualified name to its defining chapter."""
    hit = GIDX.get(gname)
    if hit:
        return hit
    # fall back: longest known gname prefix
    best = None
    for g in GIDX:
        if gname.startswith(g + ".") and (best is None or len(g) > len(best)):
            best = g
    if best:
        return GIDX[best]
    return None


def gname_decl(g):
    """The Decl object for a fully-qualified name."""
    for ds in IDX.values():
        for d in ds:
            if d.gname == g:
                return d
    return None


def token_completion(leaf, needed, node_gnames):
    """Fixpoint over DECL SPANS ONLY (docstrings/comments are excluded — they
    mention names that are not real deps and caused over-inclusion): scan the
    inlined decls' code text for identifier tokens that resolve to a known
    declaration and add them.  The sketch's vdeps are incomplete (e.g. names
    used only inside `simp [name]` in a proof are not recorded)."""
    while True:
        by_ch = {}
        for g, ch in needed.items():
            by_ch.setdefault(ch, set()).add(g)
        added = False
        for ch, gnames in by_ch.items():
            decls = wg.load_decls(ch, GRAPH)
            bt = wg.src_byte_text(ch)
            for d in decls:
                if d.gname not in gnames:
                    continue
                code = bt.slice(d.s, d.e)
                for tok in re.findall(r"\b[A-Za-z][A-Za-z0-9_']{2,}\b", code):
                    if tok in STOPWORDS:
                        continue
                    for dd in IDX.get(tok, []):
                        if dd.gname in needed or dd.gname in node_gnames:
                            continue
                        needed[dd.gname] = dd.leaf
                        added = True
        if not added:
            return needed


def complete_closure(leaf, start_names):
    """Graph closure + decl-span token completion fixpoint (re-run the graph
    closure from the grown short-name set each round)."""
    node_gnames = set()
    try:
        decls = wg.load_decls(leaf, GRAPH)
        doc = wg.module_doc(wg.src_byte_text(leaf))
        _, _, nodes, _ = wg.classify(decls, doc)
        node_gnames = {d.gname for d in nodes}
    except Exception:
        pass
    names = set(start_names)
    changed = True
    while changed:
        before = set(names)
        needed = closure(leaf, names)
        token_completion(leaf, needed, node_gnames)
        names = {g.split(".")[-1] for g in needed}
        changed = set(names) != before
    return needed


def leaf_keep_gnames(leaf):
    """For the leaf chapter keep ONLY def-material + embedded helpers (the
    node theorems are uploaded as Thm/Sol nodes and must not be inlined)."""
    keep = set()
    try:
        decls = wg.load_decls(leaf, GRAPH)
        doc = wg.module_doc(wg.src_byte_text(leaf))
        defmat, embedded, _, _ = wg.classify(decls, doc)
        for d in defmat | embedded:
            keep.add(d.gname)
    except Exception:
        pass
    return keep


def leaf_def_material_names(leaf):
    """Names of the chapter's own public defs/inductives/instances plus the
    helper theorems `classify` marks as embedded (needed by def bodies)."""
    names = set()
    try:
        decls = wg.load_decls(leaf, GRAPH)
        doc = wg.module_doc(wg.src_byte_text(leaf))
        defmat, embedded, _, _ = wg.classify(decls, doc)
        for d in defmat | embedded:
            names.add(d.name_text)
    except Exception:
        pass
    return names


def node_statement_names(leaf):
    """Every name the wave thm statements for this chapter reference (type
    deps of the node theorems) — these must resolve in the def bundle."""
    names = set()
    try:
        decls = wg.load_decls(leaf, GRAPH)
    except Exception:
        return names
    for d in decls:
        if d.kind != "theorem" or d.is_private:
            continue
        for dep in d.tdeps:
            s = dep.split(".")[-1]
            if defining_chapters(s):
                names.add(s)
    return names


def closure(leaf, start_names):
    """gname -> defining chapter, following typeDeps+valueDeps transitively for
    ALL decl kinds (theorem proofs are inlined with real proofs, so their value
    deps must be chased too).

    * The leaf's own node theorems are NOT followed (they are uploaded as
      Thm/Sol nodes, not inlined into the bundle).
    * Wave-def chapters are NOT chased (their content is published separately);
      their names are recorded but nothing from them is inlined.
    """
    node_gnames = set()
    leaf_gnames = {}
    try:
        decls = wg.load_decls(leaf, GRAPH)
        doc = wg.module_doc(wg.src_byte_text(leaf))
        defmat, embedded, nodes, _ = wg.classify(decls, doc)
        node_gnames = {d.gname for d in nodes}
        for d in defmat | embedded:
            leaf_gnames[d.gname] = leaf
    except Exception:
        pass
    # start set: leaf's own defs first; then the short names referenced by the
    # node statements resolved to their defining decls (leaf's own copies
    # preferred, falling back to the first defining chapter)
    needed = {}
    frontier = set()
    start_gnames = set()
    for n in start_names:
        hits = [d for d in IDX.get(n, [])]
        if not hits:
            continue
        leaf_hits = [d for d in hits if d.leaf == leaf]
        for d in (leaf_hits or hits[:1]):
            start_gnames.add(d.gname)
    if not start_gnames:
        start_gnames = set(leaf_gnames)
    for g in start_gnames:
        hit = gname_leaf(g)
        ch = hit[0] if hit else leaf
        needed[g] = ch
        frontier.add(g)
    while frontier:
        nxt = set()
        for g in frontier:
            d = gname_decl(g)
            if d is None:
                continue
            if d.gname in node_gnames:
                continue
            deps = list(d.tdeps) + list(d.vdeps)
            for dep in deps:
                if dep in needed:
                    continue
                hit = gname_leaf(dep)
                if hit is None:
                    continue
                ch, _ = hit
                needed[dep] = ch
                nxt.add(dep)
        frontier = nxt
    return needed


def decl_in(leaf, name):
    for d in IDX.get(name, []):
        if d.leaf == leaf:
            return d
    return None


def namespace_of(d):
    """The declaration's own namespace, from its global name."""
    parts = d.gname.split(".")
    return ".".join(parts[:-1])


def chapter_skeleton(leaf, keep_gnames, keep_ns):
    """Skeleton-subtract `leaf`'s source: keep all inter-declaration text,
    delete the declaration spans not in keep_gnames (None = keep ALL decls,
    i.e. a full chapter).  Filters imports and BookProof opens (keeping opens
    for namespaces inlined into this bundle)."""
    bt = wg.src_byte_text(leaf)
    decls = wg.load_decls(leaf, GRAPH)
    parts = []
    pos = 0
    for d in sorted(decls, key=lambda x: x.s):
        if d.s > pos:
            parts.append(bt.slice(pos, d.s))
        if keep_gnames is None or d.gname in keep_gnames:
            parts.append(bt.slice(d.s, d.e))
        pos = d.e
    parts.append(bt.slice(pos, len(bt.text.encode("utf-8"))))
    text = "".join(parts)
    # drop ALL import lines (the bundle emits `import Mathlib` itself)
    text = re.sub(r"^import [^\n]*\n", "", text, flags=re.M)
    # filter BookProof opens to namespaces inlined in THIS bundle
    out = []
    for line in text.split("\n"):
        m = re.match(r"^open (.*)$", line.strip())
        if m and "BookProof." in m.group(1):
            toks = re.split(r"\s+", m.group(1).strip())
            other = [t for t in toks if not t.startswith("BookProof.")]
            kept = [t for t in toks if t.startswith("BookProof.")
                    and (t in keep_ns or any(t.startswith(k + ".") for k in keep_ns))]
            kept = other + kept
            if kept:
                out.append("open " + " ".join(kept))
            continue
        out.append(line)
    return "\n".join(out)


def blocks_from(leaf, needed):
    """Group the needed gnames by chapter; return (blocks, all_ns) where each
    block is (ch, text) with text the skeleton-subtracted source slice."""
    # first pass: figure out all namespaces inlined (for open filtering)
    all_ns = set()
    for g, ch in needed.items():
        d = gname_decl(g)
        if d:
            all_ns.add(namespace_of(d))
    blocks = []
    # group by chapter so each chapter is skeleton-subtracted once
    by_ch = {}
    for g, ch in needed.items():
        by_ch.setdefault(ch, set()).add(g)
    for ch in sorted(by_ch):
        text = chapter_skeleton(ch, by_ch[ch], all_ns)
        if not text.strip():
            continue
        blocks.append((ch, text))
    return blocks, all_ns


def topo_order(blocks, all_ns):
    """Order (ch, text) blocks so every `open BookProof.X` / qualified
    `BookProof.X.` reference resolves to a block emitted EARLIER."""
    # namespace -> first block that defines it (by scanning `namespace BookProof.X`)
    ns_to_ch = {}
    for ch, text in blocks:
        for m in re.finditer(r"^namespace (BookProof\.[A-Za-z0-9_.']+)", text, re.M):
            ns_to_ch.setdefault(m.group(1), ch)
    deps = {ch: set() for ch, _ in blocks}
    for ch, text in blocks:
        for ref in set(re.findall(r"BookProof\.[A-Za-z0-9_.']+", text)):
            best = None
            for other_ns in ns_to_ch:
                if ref == other_ns or ref.startswith(other_ns + "."):
                    if best is None or len(other_ns) > len(best):
                        best = other_ns
            if best and ns_to_ch[best] != ch:
                deps[ch].add(ns_to_ch[best])
    order = []
    placed = set()
    remaining = set(deps)
    while remaining:
        ready = [c for c in remaining if deps[c] <= placed]
        if not ready:
            ready = [sorted(remaining)[0]]
        for c in sorted(ready):
            order.append(c)
            placed.add(c)
            remaining.discard(c)
    return order


def build_bundle(leaf, needed):
    blocks, all_ns = blocks_from(leaf, needed)
    by_ch = {ch: text for ch, text in blocks}
    parts = ["import Mathlib\n"]
    for ch in topo_order(blocks, all_ns):
        parts.append("\n" + by_ch[ch].rstrip() + "\n")
    return "\n".join(parts) + "\n"


def is_broken(leaf):
    path = f"{DEF_DIR}/Def_{leaf}.lean"
    if not os.path.exists(path):
        return True
    txt = open(path, encoding="utf-8").read()
    for m in re.finditer(r"import Definitions\.Def_(Chapter\w+)", txt):
        if m.group(1) not in WAVE_DEFS:
            return True
    return False


def main():
    args = sys.argv[1:]
    out_dir = None
    if "--out" in args:
        i = args.index("--out")
        out_dir = args[i + 1]
        del args[i:i + 2]
    if "--check" in args:
        for leaf in sorted(WAVE_DEFS):
            print(f"  {leaf}: {'BROKEN' if is_broken(leaf) else 'ok'}")
        return
    if "--all" in args:
        targets = sorted(WAVE_DEFS)
    elif "--auto" in args:
        targets = [l for l in WAVE_DEFS if is_broken(l)]
    else:
        targets = [a for a in args if a.startswith("Chapter")]
    if not targets:
        print("nothing to regenerate")
        return
    os.makedirs(out_dir or DEF_DIR, exist_ok=True)
    for leaf in targets:
        dm = leaf_def_material_names(leaf)
        ns = node_statement_names(leaf)
        needed = complete_closure(leaf, dm | ns)
        txt = build_bundle(leaf, needed)
        out = os.path.join(out_dir or DEF_DIR, f"Def_{leaf}.lean")
        with open(out, "w", encoding="utf-8") as f:
            f.write(txt)
        print(f"  {leaf}: {len(needed)} names across "
              f"{len(set(needed.values()))} chapters -> {out}")


if __name__ == "__main__":
    main()