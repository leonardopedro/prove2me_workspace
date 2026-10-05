-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_lt_iff_dist_lt
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_le_iff_dist_le
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k k' : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k < fidelityC q k' ↔ ‖q - k'‖ < ‖q - k‖ := by

  rw [← not_le, ← not_le, fidelityC_le_iff_dist_le]
