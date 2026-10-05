-- Generated from ChapterFreeFieldBornSignRepresentation.lean — theorem BookProof.ChapterFreeFieldBornSignRepresentation.flipRepresentation_specialOrthogonal_iff
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignRepresentation
open BookProof.ChapterFreeFieldBornSignRepresentation

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup



theorem BookProof.ChapterFreeFieldBornSignRepresentation.flipRepresentation_specialOrthogonal_iff
    (b : Multiplicative (Fin n → Bool)) :
    (flipRepresentation n b : Matrix (Fin n) (Fin n) ℝ) ∈
        Matrix.specialOrthogonalGroup (Fin n) ℝ ↔
      b.toAdd ∈ orientationPreservingSigns n := by sorry
