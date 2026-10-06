-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_flow_sub_flow_apply_le
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.norm_flow_sub_flow_apply_le {A B : E →L[ℂ] E} (hA : IsSelfAdjoint A)
    (t : ℝ) (ht : 0 ≤ t) (x : E) (K : ℝ)
    (hK : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖(A - B) (flow B s x)‖ ≤ K) :
    ‖flow B t x - flow A t x‖ ≤ K * t := by sorry
