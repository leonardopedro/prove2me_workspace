-- Generated from ChapterFreeFieldBornSignRepresentation.lean — solution of BookProof.ChapterFreeFieldBornSignRepresentation.det_flipRepresentation
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignRepresentation
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignMatrix_det_flipMatrix
open BookProof.ChapterFreeFieldBornSignRepresentation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Multiplicative (Fin n → Bool)) :
    Matrix.det (flipRepresentation n b : Matrix (Fin n) (Fin n) ℝ) =
      (-1 : ℝ) ^ flipCount b.toAdd := by

  exact det_flipMatrix b.toAdd
