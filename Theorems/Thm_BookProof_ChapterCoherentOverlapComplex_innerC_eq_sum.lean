-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.innerC_eq_sum
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.innerC_eq_sum (q k : EuclideanSpace ℂ (Fin n)) :
    inner ℂ q k = ∑ i, (starRingEnd ℂ) (q i) * k i := by sorry
