-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.fidelityC_le_iff_dist_le
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
open BookProof.ChapterCoherentFidelity


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}


theorem BookProof.ChapterCoherentFidelity.fidelityC_le_iff_dist_le (q k k' : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k ≤ fidelityC q k' ↔ ‖q - k'‖ ≤ ‖q - k‖ := by sorry
