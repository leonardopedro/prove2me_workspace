-- Generated from ChapterSirkWhitening.lean — theorem BookProof.ChapterSirkWhitening.rangeProj_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterSirkWhitening
open BookProof.ChapterSirkWhitening







noncomputable section


open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterSirkWhitening.rangeProj_isSelfAdjoint (V : F →L[ℂ] E) : IsSelfAdjoint (rangeProj V) := by sorry
