-- Generated from ChapterCoherentOverlapComplex.lean — theorem BookProof.ChapterCoherentOverlapComplex.bornWeightC_phase_invariant
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterCoherentOverlapComplex.bornWeightC_phase_invariant (q : EuclideanSpace ℂ (Fin n))
    (k k' : Fin m → EuclideanSpace ℂ (Fin n)) (hnorm : ∀ l, ‖k' l‖ = ‖k l‖)
    (hre : ∀ l, (inner ℂ q (k' l) : ℂ).re = (inner ℂ q (k l) : ℂ).re) (j : Fin m) :
    bornWeightC q k' j = bornWeightC q k j := by sorry
