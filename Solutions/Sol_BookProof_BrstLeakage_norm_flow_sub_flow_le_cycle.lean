-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.norm_flow_sub_flow_le_cycle
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_apply_le'
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {H B : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : IsSelfAdjoint B) (tau : ℝ) (htau : 0 ≤ tau) (w : E) :
    ‖flow H tau w - flow B tau w‖ ≤ (‖H - B‖ * tau) * ‖w‖ := by

  rw [← norm_neg]
  have := norm_flow_sub_flow_apply_le' hH hB tau htau w
  calc ‖-(flow H tau w - flow B tau w)‖ = ‖flow B tau w - flow H tau w‖ := by
        rw [neg_sub]
    _ ≤ ‖H - B‖ * ‖w‖ * tau := this
    _ = (‖H - B‖ * tau) * ‖w‖ := by ring
