-- Generated from ChapterFreeFieldBornSignRepresentation.lean — solution of BookProof.ChapterFreeFieldBornSignRepresentation.flipMatrix_injective
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignRepresentation
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignHom_flipVec_injective
open BookProof.ChapterFreeFieldBornSignRepresentation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (flipMatrix :
    (Fin n → Bool) → Matrix (Fin n) (Fin n) ℝ) := by

  intro b₁ b₂ h
  apply flipVec_injective
  ext k
  convert congrArg (fun m : Matrix (Fin n) (Fin n) ℝ => m k k) h using 1 <;>
    simp [flipMatrix]
