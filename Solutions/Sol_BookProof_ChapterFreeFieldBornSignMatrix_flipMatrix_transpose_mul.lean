-- Generated from ChapterFreeFieldBornSignMatrix.lean — solution of BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_transpose_mul
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignMatrix_flipMatrix_sq
open BookProof.ChapterFreeFieldBornSignMatrix



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    Matrix.transpose (flipMatrix b) * flipMatrix b = 1 := by

  convert flipMatrix_sq b using 1
  unfold flipMatrix
  aesop
