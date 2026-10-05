-- Generated from ChapterFreeFieldBornSignMatrix.lean — solution of BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_false
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignHom_flipVec_false
open BookProof.ChapterFreeFieldBornSignMatrix



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    flipMatrix (fun _ => false : Fin n → Bool) = 1 := by

  ext i j
  by_cases hi : i = j <;> simp_all [flipVec_false, flipMatrix]
  simp [hi, Matrix.one_apply]
