-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.fidelityC_translation_invariant
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
open BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterCoherentFidelity.fidelityC_translation_invariant (q k v : EuclideanSpace ℂ (Fin n)) :
    fidelityC (q + v) (k + v) = fidelityC q k := by sorry
