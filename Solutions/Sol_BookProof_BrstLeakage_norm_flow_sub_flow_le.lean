-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.norm_flow_sub_flow_le
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_apply_le'
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (hB : IsSelfAdjoint B) (t : ℝ) (ht : 0 ≤ t) :
    ‖flow A t - flow B t‖ ≤ ‖A - B‖ * t := by

  refine ContinuousLinearMap.opNorm_le_bound _ (by positivity) fun x => ?_
  have h := norm_flow_sub_flow_apply_le' hA hB t ht x
  have hrw : ‖(flow A t - flow B t) x‖ = ‖flow B t x - flow A t x‖ := by
    rw [ContinuousLinearMap.sub_apply, ← norm_neg, neg_sub]
  rw [hrw]
  calc ‖flow B t x - flow A t x‖ ≤ ‖A - B‖ * ‖x‖ * t := h
    _ = ‖A - B‖ * t * ‖x‖ := by ring
