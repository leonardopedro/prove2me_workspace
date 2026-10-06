-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgamma_unitary
import Mathlib
import Definitions.Def_ChapterA3
import Theorems.Thm_BookProof_ChapterA3_mgammaZ_transpose_mul
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    (mgamma μ)ᴴ * mgamma μ = 1 := by

  have hconj : (mgamma μ)ᴴ = (Int.castRingHom ℂ).mapMatrix ((mgammaZ μ)ᵀ) := by
    ext i j
    simp [mgamma, RingHom.mapMatrix_apply, Matrix.map_apply, Matrix.conjTranspose_apply,
      Matrix.transpose_apply]
  rw [hconj, mgamma, ← map_mul, mgammaZ_transpose_mul, map_one]
