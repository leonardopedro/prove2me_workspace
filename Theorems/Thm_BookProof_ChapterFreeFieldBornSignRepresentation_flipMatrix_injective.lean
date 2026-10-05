-- Generated from ChapterFreeFieldBornSignRepresentation.lean — theorem BookProof.ChapterFreeFieldBornSignRepresentation.flipMatrix_injective
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



theorem BookProof.ChapterFreeFieldBornSignRepresentation.flipMatrix_injective : Function.Injective (flipMatrix :
    (Fin n → Bool) → Matrix (Fin n) (Fin n) ℝ) := by sorry
