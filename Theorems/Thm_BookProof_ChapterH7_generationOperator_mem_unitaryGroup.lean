-- Generated from ChapterH7.lean — theorem BookProof.ChapterH7.generationOperator_mem_unitaryGroup
import Mathlib
import Definitions.Def_ChapterH7
open BookProof.ChapterH7

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}


noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

theorem BookProof.ChapterH7.generationOperator_mem_unitaryGroup (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) : generationOperator A t ∈ Matrix.unitaryGroup (Fin m) ℂ := by sorry
