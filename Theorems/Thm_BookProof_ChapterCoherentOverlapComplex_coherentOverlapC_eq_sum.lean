-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_eq_sum
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.coherentOverlapC_eq_sum (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k =
      Complex.exp (((-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 : ℝ) : ℂ)
        + ∑ i, (starRingEnd ℂ) (q i) * k i) := by sorry
