-- Generated from ChapterFreeFieldBornSignMatrix.lean — theorem BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_transpose_mul
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSignMatrix

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom



theorem BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_transpose_mul (b : Fin n → Bool) :
    Matrix.transpose (flipMatrix b) * flipMatrix b = 1 := by sorry
