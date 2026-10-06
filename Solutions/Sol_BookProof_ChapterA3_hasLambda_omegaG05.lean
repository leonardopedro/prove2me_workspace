-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.hasLambda_omegaG05
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_hasLambda_of_intModel
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : HasLambda omegaG05 (-minkowskiMat) := by

  have h := hasLambda_of_intModel omegaG05Z (-minkowskiMatZ) (by decide)
    (by intro μ; fin_cases μ <;>
      simp [minkowskiMatZ, minkowskiZ, mgammaZ, mgamma5Z, omegaG05Z])
  have e1 : (Int.castRingHom ℝ).mapMatrix omegaG05Z = omegaG05 := rfl
  have e2 : (Int.castRingHom ℝ).mapMatrix (-minkowskiMatZ) = -minkowskiMat := by
    ext i j
    simp [RingHom.mapMatrix_apply, Matrix.map_apply, minkowskiMatZ, minkowskiMat, minkowskiR]
  rw [e1, e2] at h; exact h
