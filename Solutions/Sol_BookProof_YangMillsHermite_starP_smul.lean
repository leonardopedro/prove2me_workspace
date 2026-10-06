-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.starP_smul
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
import Theorems.Thm_BookProof_YangMillsHermite_starP_C
import Theorems.Thm_BookProof_YangMillsHermite_starP_mul
open BookProof.YangMillsHermite




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (p : MvPolynomial (Fin d) ℂ) :
    starP (c • p) = ((starRingEnd ℂ) c) • starP p := by

  rw [smul_eq_C_mul, starP_mul, starP_C, smul_eq_C_mul]
