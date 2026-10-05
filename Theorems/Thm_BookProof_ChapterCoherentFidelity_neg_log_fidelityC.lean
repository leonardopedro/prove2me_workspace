-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.neg_log_fidelityC
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
open BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterCoherentFidelity.neg_log_fidelityC (q k : EuclideanSpace ℂ (Fin n)) :
    -Real.log (fidelityC q k) = ‖q - k‖ ^ 2 := by sorry
