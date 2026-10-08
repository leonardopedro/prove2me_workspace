-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_flow_sub_flow_apply_le_abs
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_apply_le
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.norm_flow_sub_flow_apply_le_abs {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (t : ℝ) (x : E) (K : ℝ) (hK : ∀ s : ℝ, ‖(A - B) (flow B s x)‖ ≤ K) :
    ‖flow B t x - flow A t x‖ ≤ K * |t| := by
  rcases le_or_gt 0 t with ht | ht
  · rw [abs_of_nonneg ht]
    exact norm_flow_sub_flow_apply_le hA t ht x K fun s _ => hK s
  · have hA' : IsSelfAdjoint (-A) := by sorry
