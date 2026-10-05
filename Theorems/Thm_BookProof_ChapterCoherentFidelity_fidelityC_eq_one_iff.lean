-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.fidelityC_eq_one_iff
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
open BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterCoherentFidelity.fidelityC_eq_one_iff (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = 1 ↔ q = k := by sorry
