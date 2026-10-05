-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.neg_log_fidelityC
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_eq_exp_neg_dist_sq
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    -Real.log (fidelityC q k) = ‖q - k‖ ^ 2 := by

  rw [fidelityC_eq_exp_neg_dist_sq, Real.log_exp, neg_neg]
