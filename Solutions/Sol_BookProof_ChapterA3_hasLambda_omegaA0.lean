-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.hasLambda_omegaA0
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_hasLambda_of_intModel
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : HasLambda omegaA0 minkowskiMat := by

  have h := hasLambda_of_intModel omegaA0Z minkowskiMatZ (by decide)
    (by intro μ; fin_cases μ <;>
      simp [minkowskiMatZ, minkowskiZ, mgammaZ, omegaA0Z])
  have e1 : (Int.castRingHom ℝ).mapMatrix omegaA0Z = omegaA0 := rfl
  have e2 : (Int.castRingHom ℝ).mapMatrix minkowskiMatZ = minkowskiMat := by
    ext i j
    simp [RingHom.mapMatrix_apply, Matrix.map_apply, minkowskiMatZ, minkowskiMat, minkowskiR]
  rw [e1, e2] at h; exact h
