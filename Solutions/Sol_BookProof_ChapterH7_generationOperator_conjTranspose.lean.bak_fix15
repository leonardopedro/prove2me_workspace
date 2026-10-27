-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.generationOperator_conjTranspose
import Mathlib
import Definitions.Def_ChapterH7
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) :
    (generationOperator A t)ᴴ = NormedSpace.exp ((Complex.I * (t : ℂ)) • A) := by

  rw [generationOperator, ← Matrix.exp_conjTranspose]
  congr 1
  rw [Matrix.conjTranspose_smul, hA.eq]
  congr 1
  simp [Complex.conj_I]
