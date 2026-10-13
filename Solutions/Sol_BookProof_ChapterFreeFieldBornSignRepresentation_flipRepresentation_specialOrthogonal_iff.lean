-- Generated from ChapterFreeFieldBornSignRepresentation.lean — solution of BookProof.ChapterFreeFieldBornSignRepresentation.flipRepresentation_specialOrthogonal_iff
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignRepresentation
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
open BookProof.ChapterFreeFieldBornSignRepresentation



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution
    (b : Multiplicative (Fin n → Bool)) :
    (flipRepresentation n b : Matrix (Fin n) (Fin n) ℝ) ∈
        Matrix.specialOrthogonalGroup (Fin n) ℝ ↔
      b.toAdd ∈ orientationPreservingSigns n := by

  rfl
