-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.bornDenomC_pos
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.bornDenomC_pos (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n))
    (j : Fin m) : 0 < ∑ l, bornNumerC q (k l) := by sorry
