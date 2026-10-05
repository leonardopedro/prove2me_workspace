-- Generated from ChapterFreeFieldBornSignOrientationSubgroup.lean — solution of BookProof.ChapterFreeFieldBornSignOrientationSubgroup.mem_orientationPreservingSigns_iff_even
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignOrientation_flipMatrix_mem_specialOrthogonalGroup_iff
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup



open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationCard


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    b ∈ orientationPreservingSigns n ↔ Even (flipCount b) := by

  rw [mem_orientationPreservingSigns_iff,
    flipMatrix_mem_specialOrthogonalGroup_iff]
