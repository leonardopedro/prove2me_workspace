-- Generated from ChapterFreeFieldBornSignRepresentation.lean — solution of BookProof.ChapterFreeFieldBornSignRepresentation.flipRepresentation_injective
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignRepresentation
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignRepresentation_flipMatrix_injective
open BookProof.ChapterFreeFieldBornSignRepresentation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective (flipRepresentation n) := by

  intro b₁ b₂ h
  apply_fun fun x => x.val at h
  exact Multiplicative.toAdd.injective (flipMatrix_injective h)
