-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.norm_flow_sub_flow_apply_le'
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_apply
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_apply_le
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (hB : IsSelfAdjoint B) (t : ℝ) (ht : 0 ≤ t) (x : E) :
    ‖flow B t x - flow A t x‖ ≤ ‖A - B‖ * ‖x‖ * t := by

  refine norm_flow_sub_flow_apply_le hA t ht x _ fun s _ => ?_
  calc ‖(A - B) (flow B s x)‖ ≤ ‖A - B‖ * ‖flow B s x‖ := (A - B).le_opNorm _
    _ = ‖A - B‖ * ‖x‖ := by rw [norm_flow_apply hB]
