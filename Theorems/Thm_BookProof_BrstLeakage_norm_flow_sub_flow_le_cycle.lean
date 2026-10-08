-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_flow_sub_flow_le_cycle
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.norm_flow_sub_flow_le_cycle {H B : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : IsSelfAdjoint B) (tau : ℝ) (htau : 0 ≤ tau) (w : E) :
    ‖flow H tau w - flow B tau w‖ ≤ (‖H - B‖ * tau) * ‖w‖ := by sorry
