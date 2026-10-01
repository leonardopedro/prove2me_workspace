-- Generated from ChapterH7.lean — theorem BookProof.ChapterH7.reduceGenerator_isHermitian
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

theorem BookProof.ChapterH7.reduceGenerator_isHermitian (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] E)
    (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) :
    (reduceGenerator m V X).IsHermitian := by sorry
