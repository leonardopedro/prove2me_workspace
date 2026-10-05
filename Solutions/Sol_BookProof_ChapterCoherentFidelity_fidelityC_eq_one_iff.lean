-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_eq_one_iff
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
    fidelityC q k = 1 ↔ q = k := by

  rw [fidelityC_eq_exp_neg_dist_sq, Real.exp_eq_one_iff, neg_eq_zero,
    pow_eq_zero_iff (two_ne_zero), norm_eq_zero, sub_eq_zero]
