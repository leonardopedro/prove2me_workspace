-- Generated from ChapterFreeFieldBornSignMatrix.lean — theorem BookProof.ChapterFreeFieldBornSignMatrix.det_flipMatrix
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSignMatrix

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom



theorem BookProof.ChapterFreeFieldBornSignMatrix.det_flipMatrix (b : Fin n → Bool) :
    Matrix.det (flipMatrix b) = (-1 : ℝ) ^ flipCount b := by sorry
