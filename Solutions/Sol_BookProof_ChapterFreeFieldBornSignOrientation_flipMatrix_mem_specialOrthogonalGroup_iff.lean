-- Generated from ChapterFreeFieldBornSignOrientation.lean — solution of BookProof.ChapterFreeFieldBornSignOrientation.flipMatrix_mem_specialOrthogonalGroup_iff
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignOrientation_flipMatrix_mem_orthogonalGroup
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignOrientation_det_flipMatrix_eq_one_iff
open BookProof.ChapterFreeFieldBornSignOrientation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    flipMatrix b ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ ↔ Even (flipCount b) := by

  rw [← det_flipMatrix_eq_one_iff b, Matrix.mem_specialOrthogonalGroup_iff]
  exact ⟨fun h => h.2, fun h => ⟨flipMatrix_mem_orthogonalGroup b, h⟩⟩
