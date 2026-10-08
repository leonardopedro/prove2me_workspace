-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.bornWeightC_eq_fidelity_normalized
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentFidelity


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}


theorem BookProof.ChapterCoherentFidelity.bornWeightC_eq_fidelity_normalized (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j = fidelityC q (k j) / ∑ l, fidelityC q (k l) := by sorry
