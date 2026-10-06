-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.bornNumerC_eq
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.bornNumerC_eq (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC q k =
      Real.exp (-‖q‖ ^ 2) * Real.exp (-‖k‖ ^ 2)
        * Real.exp (2 * (inner ℂ q k : ℂ).re) := by sorry
