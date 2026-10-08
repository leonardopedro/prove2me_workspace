-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.flow_mem_unitary
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.flow_mem_unitary {A : E →L[ℂ] E} (hA : IsSelfAdjoint A) (t : ℝ) :
    flow A t ∈ unitary (E →L[ℂ] E) := by sorry
