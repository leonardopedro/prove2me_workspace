-- Generated from ChapterFreeFieldBornSignOrientation.lean — solution of BookProof.ChapterFreeFieldBornSignOrientation.flipMatrix_transpose
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    Matrix.transpose (flipMatrix b) = flipMatrix b := by

  exact Matrix.diagonal_transpose (flipVec b)
