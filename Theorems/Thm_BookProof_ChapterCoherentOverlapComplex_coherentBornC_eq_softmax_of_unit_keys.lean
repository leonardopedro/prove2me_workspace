-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.coherentBornC_eq_softmax_of_unit_keys
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.coherentBornC_eq_softmax_of_unit_keys (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (hk : ∀ l, ‖k l‖ = 1) (j : Fin m) :
    bornWeightC q k j = softmaxC 2 q k j := by sorry
