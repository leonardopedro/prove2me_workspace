-- Generated from ChapterCoherentGeometry.lean — solution of BookProof.ChapterCoherentGeometry.bornWeight_lt_of_nearest
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Theorems.Thm_BookProof_ChapterCoherentGeometry_bornWeight_le_iff_dist_le
open BookProof.ChapterCoherentGeometry



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m)
    (hij : ‖q - k j‖ < ‖q - k i‖) :
    bornWeight q k i < bornWeight q k j := by

  rw [← not_le, bornWeight_le_iff_dist_le]
  exact not_le.2 hij
