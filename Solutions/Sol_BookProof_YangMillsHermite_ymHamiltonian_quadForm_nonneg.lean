-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.ymHamiltonian_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
import Theorems.Thm_BookProof_YangMillsHermite_piOps_symmetricOn
import Theorems.Thm_BookProof_YangMillsHermite_magOps_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg
open BookProof.YangMillsHermite




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 99 D) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)
    (x : D) : 0 ≤ quadForm (ymHamiltonian Φ fabc) x := weylOpDom_quadForm_nonneg (piOps_symmetricOn Φ) (magOps_symmetricOn Φ fabc) x
