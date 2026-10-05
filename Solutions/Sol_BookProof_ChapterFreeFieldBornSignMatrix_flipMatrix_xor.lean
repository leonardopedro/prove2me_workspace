-- Generated from ChapterFreeFieldBornSignMatrix.lean — solution of BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_xor
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignMatrix



open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b₁ b₂ : Fin n → Bool) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) = flipMatrix b₁ * flipMatrix b₂ := by

  ext i j
  by_cases hi : i = j <;> simp [hi, flipMatrix, flipVec]
  grind +splitImp
