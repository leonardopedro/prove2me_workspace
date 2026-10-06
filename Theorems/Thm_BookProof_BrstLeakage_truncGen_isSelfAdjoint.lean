-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.truncGen_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.truncGen_isSelfAdjoint {P H : E →L[ℂ] E} (hP : IsSelfAdjoint P)
    (hH : IsSelfAdjoint H) : IsSelfAdjoint (truncGen P H) := by sorry
