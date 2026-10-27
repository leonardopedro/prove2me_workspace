-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.generationOperator_mem_unitaryGroup
import Mathlib
import Definitions.Def_ChapterH7
import Theorems.Thm_BookProof_ChapterH7_generationOperator_conjTranspose_mul
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
    (hA : A.IsHermitian) : generationOperator A t ∈ Matrix.unitaryGroup (Fin m) ℂ := by

  have h := generationOperator_conjTranspose_mul A t hA
  refine ⟨?_, ?_⟩
  · simpa [Matrix.star_eq_conjTranspose] using h
  · have hinv : (generationOperator A t) * (generationOperator A t)ᴴ = 1 :=
      (mul_eq_one_comm_of_card_eq (Fin m) (Fin m) ℂ rfl).mp h
    simpa [Matrix.star_eq_conjTranspose] using hinv
