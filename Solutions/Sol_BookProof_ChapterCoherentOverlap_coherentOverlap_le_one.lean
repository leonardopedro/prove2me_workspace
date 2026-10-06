-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.coherentOverlap_le_one
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
import Theorems.Thm_BookProof_ChapterCoherentOverlap_coherentOverlap_eq_gaussian
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k ≤ 1 := by

  rw [coherentOverlap_eq_gaussian, Real.exp_le_one_iff]
  have : (0 : ℝ) ≤ ‖q - k‖ ^ 2 := sq_nonneg _
  linarith
