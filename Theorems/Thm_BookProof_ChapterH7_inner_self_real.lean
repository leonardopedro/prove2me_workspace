-- Generated from ChapterH7.lean — theorem BookProof.ChapterH7.inner_self_real
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

theorem BookProof.ChapterH7.inner_self_real (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) (x : E) :
    (inner ℂ x (X x) : ℂ).im = 0 := by sorry
