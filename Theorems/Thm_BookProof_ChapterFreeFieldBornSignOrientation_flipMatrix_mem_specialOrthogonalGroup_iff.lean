-- Generated from ChapterFreeFieldBornSignOrientation.lean — theorem BookProof.ChapterFreeFieldBornSignOrientation.flipMatrix_mem_specialOrthogonalGroup_iff
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientation


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignOrientation.flipMatrix_mem_specialOrthogonalGroup_iff (b : Fin n → Bool) :
    flipMatrix b ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ ↔ Even (flipCount b) := by sorry
