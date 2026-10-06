-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.norm_coherentOverlapC
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    ‖coherentOverlapC q k‖
      = Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + (inner ℂ q k : ℂ).re) := by

  rw [coherentOverlapC, Complex.norm_exp]
  simp [-Complex.ofReal_pow]
