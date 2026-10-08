-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_flow_sub_flow_apply_le'
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.norm_flow_sub_flow_apply_le_prime {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (hB : IsSelfAdjoint B) (t : ℝ) (ht : 0 ≤ t) (x : E) :
    ‖flow B t x - flow A t x‖ ≤ ‖A - B‖ * ‖x‖ * t := by sorry
