-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_le_iff_dist_le
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
theorem solution (q k k' : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k ≤ fidelityC q k' ↔ ‖q - k'‖ ≤ ‖q - k‖ := by

  rw [fidelityC_eq_exp_neg_dist_sq, fidelityC_eq_exp_neg_dist_sq, Real.exp_le_exp,
    neg_le_neg_iff]
  constructor
  · intro h; nlinarith [norm_nonneg (q - k), norm_nonneg (q - k')]
  · intro h; nlinarith [norm_nonneg (q - k), norm_nonneg (q - k')]
