-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.coherentOverlap_eq
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
import Theorems.Thm_BookProof_ChapterCoherentOverlap_norm_sq_eq_sum
import Theorems.Thm_BookProof_ChapterCoherentOverlap_inner_eq_sum
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k =
      Real.exp (-(∑ i, q i * q i) / 2 - (∑ i, k i * k i) / 2 + ∑ i, q i * k i) := by

  rw [coherentOverlap, norm_sq_eq_sum, norm_sq_eq_sum, inner_eq_sum]
