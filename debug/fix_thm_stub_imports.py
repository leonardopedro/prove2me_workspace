#!/usr/bin/env python3
"""Add the `Theorems.Thm_*` stub import (and `open`) a def bundle needs for a
cross-bundle theorem it references.

Why: the platform stores a *defs-only* projection of every published bundle
(measured 2026-10-20: Def_ChapterNsLagrangianDetConvolution has 16 defs and 0
theorems, 173 lines vs the workspace's 361).  build_candidate_mirror stages that
platform text for published bundles, so a bundle whose proof cites a *theorem*
from a published dependency cannot resolve it from the bundle alone -- each such
theorem is published as its own `Theorems.Thm_*` stub (statement + `sorry`), and
322 OK bundles import stubs exactly this way.  A missing stub import therefore
surfaces as `Unknown identifier`, which reads like a dropped declaration.

Usage:  python3 debug/fix_thm_stub_imports.py [--dry]
"""
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# (bundle, stub module or None, namespace declaring the missing identifier)
FIXES = [
    ("SqSumOuterFamily", "Theorems.Thm_BookProof_DirectSumEsa_dsCore_dense",
     "BookProof.DirectSumEsa"),
    ("VonNeumannCore", "Theorems.Thm_BookProof_ClosureUniqueness_opGraph_clExt",
     "BookProof.ClosureUniqueness"),
    ("NsLagrangianDetFarisLavine", "Theorems.Thm_BookProof_NsLagrangianDet_volPot_eval_nonneg",
     "BookProof.NsLagrangianDet"),
    ("WallDeficiencyObstruction", "Theorems.Thm_BookProof_WeakSecondDeriv_integrable_test_smul",
     "BookProof.WeakSecondDeriv"),
    ("NavierStokesSignFlip",
     "Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_affH_essentiallySelfAdjointOn_core",
     "BookProof.NavierStokesFlow.AffineFiber"),
    ("A2e", "Theorems.Thm_BookProof_ChapterA_Rpseudoreal_realCommutant_eq_quaternion",
     "BookProof.ChapterA"),
    ("FockSchurEsa", "Theorems.Thm_BookProof_FockSecondQuantization_support_up",
     "BookProof.FockSecondQuantization"),
    ("FockPairPerturbation", "Theorems.Thm_BookProof_FockSecondQuantization_dn_up",
     "BookProof.FockSecondQuantization"),
    ("FermionFock", "Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists",
     "BookProof.FriedrichsExtension"),
    # import already present; only the namespace open is missing
    ("ScalaronOuterFockFL", None, "BookProof.StrichartzWave"),
]


def main():
    dry = "--dry" in sys.argv
    changed = []
    for bundle, stub, idents in FIXES:
        path = os.path.join(WS, "Definitions", f"Def_Chapter{bundle}.lean")
        txt = open(path, encoding="utf-8").read()
        orig = txt
        if stub and f"import {stub}\n" not in txt:
            lines = txt.split("\n")
            last_imp = max(i for i, l in enumerate(lines) if l.startswith("import "))
            lines.insert(last_imp + 1, f"import {stub}")
            txt = "\n".join(lines)
        first_ns = re.search(r"^namespace (\S+)", txt, re.M)
        ns = first_ns.group(1) if first_ns else ""
        # covered if the caller is inside the declaring namespace, or already
        # opens it (on any `open` line)
        covered = ns == idents
        if not covered:
            for m in re.finditer(r"^open[^\n]*$", txt, re.M):
                if re.search(r"\b" + re.escape(idents) + r"\b", m.group(0)):
                    covered = True
                    break
        if not covered:
            m = re.search(r"^namespace \S[^\n]*\n", txt, re.M)
            if m:
                txt = txt[:m.end()] + f"open {idents}\n" + txt[m.end():]
            else:
                txt = f"open {idents}\n" + txt
        if txt != orig:
            if not dry:
                open(path, "w", encoding="utf-8").write(txt)
            changed.append(bundle)
            print(f"  {'would update' if dry else 'UPDATED'} {bundle}")
        else:
            print(f"  unchanged {bundle} (already satisfied)")
    print(f"\n{len(changed)} bundle(s) {'would change' if dry else 'updated'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
