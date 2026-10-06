-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_eq_modulus_mul_phase
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_eq_modulus_mul_phase (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k =
      (Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + (inner ℂ q k : ℂ).re) : ℂ) *
        Complex.exp (((inner ℂ q k : ℂ).im : ℂ) * Complex.I) := by sorry
