-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.normSq_toLp_wgt
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wgt_apply
import Theorems.Thm_BookProof_FockWeightedSchur_support_wgt_subset
import Theorems.Thm_BookProof_FockSchur_normSq_toLp_of_subset
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) :
    ‖toLp (wgt w u)‖ ^ 2 = ∑ α ∈ u.support, wSym w α ^ 2 * ‖u α‖ ^ 2 := by

  rw [normSq_toLp_of_subset (support_wgt_subset u)]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [wgt_apply, norm_mul, mul_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs]
