-- Generated from ChapterYangMillsHermite.lean — solution of BookProof.YangMillsHermite.ymHamiltonian_apply
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOp_apply
open BookProof.YangMillsHermite




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 99 D) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (x : D) :
    ymHamiltonian Φ fabc x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ m, ((piOps Φ m (piOps Φ m x) : D) : L2d 99))
            + ∑ m, ((magOps Φ fabc m (magOps Φ fabc m x) : D) : L2d 99)) := weylOp_apply _ _ x
