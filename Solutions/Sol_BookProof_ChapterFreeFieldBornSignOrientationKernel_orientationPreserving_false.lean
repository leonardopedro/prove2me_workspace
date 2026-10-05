-- Generated from ChapterFreeFieldBornSignOrientationKernel.lean — solution of BookProof.ChapterFreeFieldBornSignOrientationKernel.orientationPreserving_false
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationKernel
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignOrientation_flipMatrix_mem_specialOrthogonalGroup_iff
open BookProof.ChapterFreeFieldBornSignOrientationKernel



open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    flipMatrix (fun _ => false : Fin n → Bool) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ := by

  rw [flipMatrix_mem_specialOrthogonalGroup_iff]
  simp [flipCount]
