-- Generated from ChapterH7.lean — theorem BookProof.ChapterH7.generatedState_eq_generationOperator
import Definitions.Def_ChapterH4
import Mathlib
import Definitions.Def_ChapterH7
import Definitions.Def_ChapterH6
open BookProof.ChapterH6
open BookProof.ChapterH7

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}


noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

theorem BookProof.ChapterH7.generatedState_eq_generationOperator (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (psi0 : Fin m → ℂ) :
    generatedState A (t : ℂ) psi0 = (generationOperator A t).mulVec psi0 := by sorry
