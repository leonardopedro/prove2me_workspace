-- Generated from ChapterFreeFieldBornSignOrientation.lean — theorem BookProof.ChapterFreeFieldBornSignOrientation.det_flipMatrix_eq_one_iff
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


theorem BookProof.ChapterFreeFieldBornSignOrientation.det_flipMatrix_eq_one_iff (b : Fin n → Bool) :
    Matrix.det (flipMatrix b) = 1 ↔ Even (flipCount b) := by sorry
