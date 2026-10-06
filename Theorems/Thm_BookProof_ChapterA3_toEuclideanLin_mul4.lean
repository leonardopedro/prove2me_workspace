-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.toEuclideanLin_mul4
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.toEuclideanLin_mul4 (A B : Matrix (Fin 4) (Fin 4) ℂ) :
    Matrix.toEuclideanLin (A * B)
      = (Matrix.toEuclideanLin A) ∘ₗ (Matrix.toEuclideanLin B) := by sorry
