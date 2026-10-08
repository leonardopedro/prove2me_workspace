-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.compress_nonneg
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
import Mathlib
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterH9


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


theorem BookProof.ChapterH9.compress_nonneg (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hX : ∀ x : E, 0 ≤ (inner ℂ x (X x) : ℂ).re) (y : F) :
    0 ≤ (inner ℂ y (compress V X y) : ℂ).re := by sorry
