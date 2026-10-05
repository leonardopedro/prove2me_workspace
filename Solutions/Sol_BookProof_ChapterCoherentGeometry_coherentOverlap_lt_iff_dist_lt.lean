-- Generated from ChapterCoherentGeometry.lean — solution of BookProof.ChapterCoherentGeometry.coherentOverlap_lt_iff_dist_lt
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Theorems.Thm_BookProof_ChapterCoherentGeometry_coherentOverlap_le_iff_dist_le
open BookProof.ChapterCoherentGeometry



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k k' : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k < coherentOverlap q k' ↔ ‖q - k'‖ < ‖q - k‖ := by

  rw [← not_le, ← not_le, coherentOverlap_le_iff_dist_le]
