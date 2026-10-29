#!/usr/bin/env python3
"""Break the text-level import cycles that OOM the box on load (2026-10-29).

Six SCCs exist in the workspace import graph (Tarjan on Definitions/ +
Theorems/).  Loading ANY module whose baked-olean closure contains one of
them balloons lean to the 11 GiB watchdog cap in ~11 s (proved with pure
`import` one-liners, debug/lean_watch.py).  Every cut below was vetted:

  * reference scan  -- the cutting file cites no decl of the cut module
    (0 hits), or the hit resolves through a different module;
  * reachability    -- SCC3 cuts are also redundant (module still reachable
    through other imports), so Lean's transitive resolution keeps working.

Cuts (13 files, one edge each unless noted):
  SCC1  Def_ChapterFarisLavine              -> NavierStokesAffineFiberEsa
        (the only intra-SCC1 out-edge of FarisLavine; every cycle passes it.
         `HasZeroDeficiencyOn` cited in FL lives in Def_ChapterNavierStokesFlow.)
  SCC2  Thm_..StoneMeasurable_norm_le_..    -> StoneConverse
        (StoneConverse's body cites the STUB theorem at line 439, so the
         bundle side must stay; the stub cites nothing from StoneConverse.)
  SCC3  Thm_..H8_coordIncl_adjoint_comp     -> ShiftedQuadraticEsa (0 refs)
        Thm_..H8_orthonormalEmbedding_..    -> ShiftedQuadraticEsa (0 refs)
        Thm_..galerkinCompression_tendsto   -> HermiteGalerkinFriedrichs (redundant)
  SCC4  Thm_..DifferentialL2_coreOp_coe     -> QgOuterFockCoreFL (+ 2 opens)
        (statement's `coreEquiv` types to DifferentialL2's def
         `MvPolynomial ... ≃ₗ polyGaussCore`, NOT CoreFL's `d.C₀ ≃ₗ d.coreRange`;
         `coreOp` lives in DifferentialL2; polyGaussCore/pgLp/L2d in HermiteProductCore.)
  SCC5  5x Thm_..ScalaronFiberFL_*          -> QgOuterFockFlow (0 refs each)
  SCC6  2x Thm_..QgTimeStepping/QgTrunc..   -> QgTimeIndependentFlow (0 refs each)

After the edits: recompute SCCs (must be 0), copy edited files into the
candidate mirror, delete their stale .oleans -- they must be rebuilt under
debug/lean_watch.py before any regate, or the baked back-edges keep the
cycle alive in olean-land.

Usage:  python3 debug/cut_import_cycles.py [--check-only]
"""
import collections
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
BAK = os.path.join(WS, "state", "scratch", "cycle_cuts")

# (file, [exact full lines to delete])
CUTS = [
    ("Definitions/Def_ChapterFarisLavine.lean",
     ["import Definitions.Def_ChapterNavierStokesAffineFiberEsa"]),
    ("Theorems/Thm_BookProof_ChapterStoneMeasurable_norm_le_of_inner_self_bound.lean",
     ["import Definitions.Def_ChapterStoneConverse"]),
    ("Theorems/Thm_BookProof_ChapterH8_coordIncl_adjoint_comp.lean",
     ["import Definitions.Def_ChapterShiftedQuadraticEsa"]),
    ("Theorems/Thm_BookProof_ChapterH8_orthonormalEmbedding_adjoint_comp.lean",
     ["import Definitions.Def_ChapterShiftedQuadraticEsa"]),
    ("Theorems/Thm_BookProof_HermiteGalerkin_galerkinCompression_tendsto.lean",
     ["import Definitions.Def_ChapterHermiteGalerkinFriedrichs"]),
    ("Theorems/Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe.lean",
     ["import Definitions.Def_ChapterQgOuterFockCoreFL",
      "open BookProof.QgOuterFockCoreFL",
      "open BookProof.QgOuterFockCoreFL.CoreData"]),
    ("Theorems/Thm_BookProof_ScalaronFiberFL_WallPot_comparison_core.lean",
     ["import Definitions.Def_ChapterQgOuterFockFlow"]),
    ("Theorems/Thm_BookProof_ScalaronFiberFL_WallPot_core_le_dom.lean",
     ["import Definitions.Def_ChapterQgOuterFockFlow"]),
    ("Theorems/Thm_BookProof_ScalaronFiberFL_WallPot_ham_esa.lean",
     ["import Definitions.Def_ChapterQgOuterFockFlow"]),
    ("Theorems/Thm_BookProof_ScalaronFiberFL_cc_integrable.lean",
     ["import Definitions.Def_ChapterQgOuterFockFlow"]),
    ("Theorems/Thm_BookProof_ScalaronFiberFL_norm_xCc_sq_le.lean",
     ["import Definitions.Def_ChapterQgOuterFockFlow"]),
    ("Theorems/Thm_BookProof_QgTimeStepping_qgOuterFock_fullyDiscrete_convergence.lean",
     ["import Definitions.Def_ChapterQgTimeIndependentFlow"]),
    ("Theorems/Thm_BookProof_QgTruncationResolvent_qgOuterFock_truncation_flow_convergence.lean",
     ["import Definitions.Def_ChapterQgTimeIndependentFlow"]),
]


def import_graph():
    imp = collections.defaultdict(set)
    for d in ("Definitions", "Theorems"):
        for f in os.listdir(os.path.join(WS, d)):
            if not f.endswith(".lean"):
                continue
            key = f"{d}/{f[:-5]}"
            with open(os.path.join(WS, d, f), encoding="utf-8",
                      errors="ignore") as fh:
                for line in fh:
                    m = re.match(r"^import (Definitions|Theorems)\.(\S+)", line)
                    if m:
                        imp[key].add(f"{m.group(1)}/{m.group(2)}")
    return imp


def sccs_of(imp):
    idx, low, on, st, cnt, out = {}, {}, set(), [], [0], []

    def strong(v):
        idx[v] = low[v] = cnt[0]
        cnt[0] += 1
        st.append(v)
        on.add(v)
        for w in imp.get(v, ()):
            if w not in idx:
                strong(w)
                low[v] = min(low[v], low[w])
            elif w in on:
                low[v] = min(low[v], idx[w])
        if low[v] == idx[v]:
            c = []
            while True:
                w = st.pop()
                on.discard(w)
                c.append(w)
                if w == v:
                    break
            if len(c) > 1:
                out.append(c)

    for v in list(imp):
        if v not in idx:
            strong(v)
    return out


def decls_of(path):
    t = open(path, encoding="utf-8", errors="ignore").read()
    names = set()
    for m in re.finditer(
            r"^(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?(?:protected\s+)?"
            r"(?:def|theorem|lemma|abbrev|structure|class|instance)\s+"
            r"([^\s:{(\[]+)", t, re.M):
        names.add(m.group(1).split(".")[-1])
    return names


def main():
    check_only = "--check-only" in sys.argv
    fl = os.path.join(WS, "Definitions/Def_ChapterFarisLavine.lean")
    nsaf = os.path.join(WS, "Definitions/Def_ChapterNavierStokesAffineFiberEsa.lean")
    fl_t = open(fl, encoding="utf-8", errors="ignore").read()
    hits = [d for d in decls_of(nsaf)
            if len(d) > 5 and re.search(r"\b" + re.escape(d) + r"\b", fl_t)]
    # exclude self-similar names FarisLavine defines itself
    own = decls_of(fl)
    hits = [h for h in hits if h not in own]
    if hits:
        print(f"BLOCKED: FarisLavine references NSAffineFiberEsa decls: {hits}")
        return 1
    print("FL pre-check ok: FarisLavine cites 0 NSAffineFiberEsa decls")

    missing = [(f, ls) for f, ls in CUTS
               if not os.path.exists(os.path.join(WS, f))]
    if missing:
        print("missing files:", missing)
        return 1

    if check_only:
        s = sccs_of(import_graph())
        print(f"current SCCs: {len(s)}")
        return 0

    os.makedirs(BAK, exist_ok=True)
    synced = []
    for rel, lines in CUTS:
        p = os.path.join(WS, rel)
        shutil.copy2(p, os.path.join(BAK, os.path.basename(rel)))
        out, removed = [], []
        for line in open(p, encoding="utf-8", errors="ignore"):
            s = line.rstrip("\n")
            if s in lines:
                removed.append(s)
                continue
            out.append(line)
        bad = [l for l in lines if l not in removed]
        if bad:
            print(f"BLOCKED: {rel}: lines not found: {bad}")
            return 1
        open(p, "w", encoding="utf-8").write("".join(out))
        # sync into the mirror + drop the stale olean (baked back-edge)
        mrel = rel.replace("Definitions/", "Definitions/", 1)
        mpath = os.path.join(MIRROR, rel)
        if os.path.exists(os.path.dirname(mpath)):
            shutil.copy2(p, mpath)
        olean = os.path.join(MIRROR, rel[:-5] + ".olean")
        if os.path.exists(olean):
            os.remove(olean)
        synced.append(rel)
        print(f"cut {len(removed)} line(s): {rel}")

    s = sccs_of(import_graph())
    if s:
        print(f"\nSTILL {len(s)} SCCs after cuts:")
        for c in s:
            print("  ", sorted(c))
        return 1
    print(f"\nimport graph acyclic: 0 SCCs  ({len(synced)} files edited, "
          f"stale oleans removed from mirror)")
    print("rebuild next (in this order):")
    for rel in synced:
        print("  ", rel[:-5])
    return 0


if __name__ == "__main__":
    sys.exit(main())
