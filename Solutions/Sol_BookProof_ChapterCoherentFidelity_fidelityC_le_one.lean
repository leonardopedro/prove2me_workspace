-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_le_one
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
theorem solution (q k : EuclideanSpace ℂ (Fin n)) : fidelityC q k ≤ 1 := by

  rw [fidelityC_eq_exp_neg_dist_sq, Real.exp_le_one_iff, neg_nonpos]
  positivity
