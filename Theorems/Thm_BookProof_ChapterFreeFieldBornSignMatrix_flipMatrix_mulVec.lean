-- Generated from ChapterFreeFieldBornSignMatrix.lean — theorem BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_mulVec
import Definitions.Def_ChapterFreeFieldBornSignAction
import Definitions.Def_ChapterFreeFieldBornSignHom
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignMatrix

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom



theorem BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_mulVec (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    (flipMatrix b).mulVec x = boolFlip b x := by sorry
