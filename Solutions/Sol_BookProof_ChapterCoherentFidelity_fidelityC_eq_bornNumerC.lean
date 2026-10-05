-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_eq_bornNumerC
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = bornNumerC q k := rfl
