-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.norm_coherentOverlapC
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.norm_coherentOverlapC (q k : EuclideanSpace ℂ (Fin n)) :
    ‖coherentOverlapC q k‖
      = Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + (inner ℂ q k : ℂ).re) := by sorry
