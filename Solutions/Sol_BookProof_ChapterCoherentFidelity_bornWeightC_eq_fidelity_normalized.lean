-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.bornWeightC_eq_fidelity_normalized
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j = fidelityC q (k j) / ∑ l, fidelityC q (k l) := rfl
