-- Generated from ChapterFreeFieldBornSignOrientation.lean — theorem BookProof.ChapterFreeFieldBornSignOrientation.flipMatrix_transpose
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientation

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix



theorem BookProof.ChapterFreeFieldBornSignOrientation.flipMatrix_transpose (b : Fin n → Bool) :
    Matrix.transpose (flipMatrix b) = flipMatrix b := by sorry
