-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_eq_modulus_mul_phase
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k =
      (Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + (inner ℂ q k : ℂ).re) : ℂ) *
        Complex.exp (((inner ℂ q k : ℂ).im : ℂ) * Complex.I) := by

  rw [coherentOverlapC, Complex.ofReal_exp, ← Complex.exp_add]
  congr 1
  apply Complex.ext <;> simp [-Complex.ofReal_pow]
