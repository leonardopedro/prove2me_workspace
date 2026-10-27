-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.norm_leakageIter
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_apply
import Theorems.Thm_BookProof_BrstLeakage_leakageIter_succ
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {B : ℕ → E →L[ℂ] E} (hB : ∀ i, IsSelfAdjoint (B i)) (τ : ℝ) (x : E) :
    ∀ n, ‖leakageIter B τ x n‖ = ‖x‖
  | 0 => rfl
  | n + 1 => by
      rw [leakageIter_succ, norm_flow_apply (hB n), norm_leakageIter hB τ x n]

/-- **Accumulated leakage over restarts.**  With a fresh truncation each cycle, the BRST
content grows at most linearly in the number of cycles. -/
theorem leakage_iterate_le {H Om : E →L[ℂ] E} {B : ℕ → E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : ∀ i, IsSelfAdjoint (B i)) (hcomm : Commute H Om) (τ : ℝ) (hτ : 0 ≤ τ) (x : E)
    (K : ℝ) (hK : ∀ i, ‖H - B i‖ ≤ K) :
    ∀ n : ℕ, ‖Om (leakageIter B τ x n)‖ ≤ ‖Om x‖ + n * (‖Om‖ * (K * ‖x‖ * τ))
  | 0 => by simp
  | n + 1 => by
      have hxn : ‖leakageIter B τ x n‖ = ‖x‖
| 0 => rfl
  | n + 1 => by
      rw [leakageIter_succ, norm_flow_apply (hB n), solution hB τ x n]
