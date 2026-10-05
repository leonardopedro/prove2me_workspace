-- Generated from ChapterFreeFieldBornSignOrientation.lean — solution of BookProof.ChapterFreeFieldBornSignOrientation.det_flipMatrix_eq_one_iff
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignMatrix_det_flipMatrix
open BookProof.ChapterFreeFieldBornSignOrientation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    Matrix.det (flipMatrix b) = 1 ↔ Even (flipCount b) := by

  rw [det_flipMatrix]
  exact neg_one_pow_eq_one_iff_even (by norm_num)
