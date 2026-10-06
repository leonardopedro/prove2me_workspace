-- Generated from ChapterPauliCommutant.lean — solution of BookProof.ChapterA3.toEuclideanLin_mul4
import Mathlib
import Definitions.Def_ChapterPauliCommutant
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin 4) (Fin 4) ℂ) :
    Matrix.toEuclideanLin (A * B)
      = (Matrix.toEuclideanLin A) ∘ₗ (Matrix.toEuclideanLin B) := by

  ext x i
  simp [Matrix.mulVec_mulVec]
