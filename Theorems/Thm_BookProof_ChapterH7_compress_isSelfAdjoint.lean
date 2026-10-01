-- Generated from ChapterH7.lean — theorem BookProof.ChapterH7.compress_isSelfAdjoint
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

theorem BookProof.ChapterH7.compress_isSelfAdjoint (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) :
    IsSelfAdjoint (compress V X) := by sorry
