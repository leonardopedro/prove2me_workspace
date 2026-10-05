-- Generated from ChapterFreeFieldBornSignMatrix.lean — solution of BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_mulVec
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignMatrix



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    (flipMatrix b).mulVec x = boolFlip b x := by

  unfold boolFlip flipMatrix Matrix.mulVec
  aesop
