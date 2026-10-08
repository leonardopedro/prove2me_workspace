-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.norm_flow_sub_flow_apply_le_abs
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_apply_le
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (t : ℝ) (x : E) (K : ℝ) (hK : ∀ s : ℝ, ‖(A - B) (flow B s x)‖ ≤ K) :
    ‖flow B t x - flow A t x‖ ≤ K * |t| := by
  rcases le_or_gt 0 t with ht | ht
  · rw [abs_of_nonneg ht]
    exact norm_flow_sub_flow_apply_le hA t ht x K fun s _ => hK s
  · have hA' : IsSelfAdjoint (-A) :=
  hA.neg
      have hK' : ∀ s ∈ Set.Icc (0 : ℝ) (-t), ‖((-A) - (-B)) (flow (-B) s x)‖ ≤ K := by
        intro s _
        have h1 : ((-A) - (-B)) = -(A - B) := by abel
        rw [h1, flow_neg_gen]
        rw [ContinuousLinearMap.neg_apply, norm_neg]
        exact hK (-s)
      have := norm_flow_sub_flow_apply_le hA' (-t) (by linarith) x K hK'
      rw [flow_neg_gen, flow_neg_gen, neg_neg] at this
      rwa [abs_of_neg ht]
