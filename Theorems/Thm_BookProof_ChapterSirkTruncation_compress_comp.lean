-- Generated from ChapterSirkTruncation.lean — theorem BookProof.ChapterSirkTruncation.compress_comp
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterSirkWhitening
import Mathlib
import Definitions.Def_ChapterSirkTruncation
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterSirkTruncation

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterSirkEndToEnd
open BookProof.ChapterSirkWhitening


theorem BookProof.ChapterSirkTruncation.compress_comp (V : F →L[ℂ] E) (W : G →L[ℂ] F) (X : E →L[ℂ] E) :
    compress (V.comp W) X = compress W (compress V X) := by sorry
