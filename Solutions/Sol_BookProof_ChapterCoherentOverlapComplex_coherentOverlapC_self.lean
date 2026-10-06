-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_self
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q q = 1 := by

  rw [coherentOverlapC, inner_self_eq_norm_sq_to_K]
  norm_num
  rw [show -(‖q‖ : ℂ) ^ 2 / 2 - (‖q‖ : ℂ) ^ 2 / 2 + (‖q‖ : ℂ) ^ 2 = 0 from by ring]
  exact Complex.exp_zero
