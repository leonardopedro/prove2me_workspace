-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_flow_sub_flow_le
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.norm_flow_sub_flow_le {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (hB : IsSelfAdjoint B) (t : ℝ) (ht : 0 ≤ t) :
    ‖flow A t - flow B t‖ ≤ ‖A - B‖ * t := by sorry
