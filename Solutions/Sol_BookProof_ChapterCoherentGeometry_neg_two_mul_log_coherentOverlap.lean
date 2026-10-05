-- Generated from ChapterCoherentGeometry.lean — solution of BookProof.ChapterCoherentGeometry.neg_two_mul_log_coherentOverlap
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
open BookProof.ChapterCoherentGeometry



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    -2 * Real.log (coherentOverlap q k) = ‖q - k‖ ^ 2 := by

  rw [coherentOverlap_eq_gaussian, Real.log_exp]
  ring
