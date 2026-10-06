-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.coherentOverlap_eq_gaussian
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
import Theorems.Thm_BookProof_ChapterCoherentOverlap_norm_sub_sq_expand
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = Real.exp (-‖q - k‖ ^ 2 / 2) := by

  rw [coherentOverlap, norm_sub_sq_expand]
  ring_nf
