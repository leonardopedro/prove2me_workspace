-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.adjoint_compress
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterH8

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.adjoint_compress (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    adjoint (compress V X) = compress V (adjoint X) := by sorry
