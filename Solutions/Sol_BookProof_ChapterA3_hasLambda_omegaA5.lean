-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.hasLambda_omegaA5
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_castMat_neg_one
import Theorems.Thm_BookProof_ChapterA3_hasLambda_of_intModel
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : HasLambda omegaA5 (-1) := by

  have h := hasLambda_of_intModel omegaA5Z (-1) (by decide) (by decide)
  have e1 : (Int.castRingHom ℝ).mapMatrix omegaA5Z = omegaA5 := rfl
  rw [e1, castMat_neg_one] at h; exact h
