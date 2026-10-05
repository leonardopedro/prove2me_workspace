-- Generated from ChapterFreeFieldBornSignMatrix.lean — solution of BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_sq
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignMatrix



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    flipMatrix b * flipMatrix b = 1 := by

  ext i j
  by_cases hi : i = j <;> simp_all [flipMatrix, flipVec]
  simp [hi, Matrix.one_apply]
