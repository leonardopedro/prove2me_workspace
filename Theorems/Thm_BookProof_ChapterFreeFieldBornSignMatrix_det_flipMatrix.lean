-- Generated from ChapterFreeFieldBornSignMatrix.lean — theorem BookProof.ChapterFreeFieldBornSignMatrix.det_flipMatrix
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignMatrix


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignMatrix.det_flipMatrix (b : Fin n → Bool) :
    Matrix.det (flipMatrix b) = (-1 : ℝ) ^ flipCount b := by sorry
