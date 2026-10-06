-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_eq_sum
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_innerC_eq_sum
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k =
      Complex.exp (((-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 : ℝ) : ℂ)
        + ∑ i, (starRingEnd ℂ) (q i) * k i) := by

  rw [coherentOverlapC, innerC_eq_sum]
