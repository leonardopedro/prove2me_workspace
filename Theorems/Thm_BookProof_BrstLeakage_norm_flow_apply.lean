-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_flow_apply
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.norm_flow_apply {A : E →L[ℂ] E} (hA : IsSelfAdjoint A) (t : ℝ) (x : E) :
    ‖flow A t x‖ = ‖x‖ := by sorry
