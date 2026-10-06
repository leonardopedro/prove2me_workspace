-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.leakage_iterate_le
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_apply
import Theorems.Thm_BookProof_BrstLeakage_leakage_le
import Theorems.Thm_BookProof_BrstLeakage_leakageIter_succ
import Theorems.Thm_BookProof_BrstLeakage_norm_leakageIter
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {H Om : E →L[ℂ] E} {B : ℕ → E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : ∀ i, IsSelfAdjoint (B i)) (hcomm : Commute H Om) (τ : ℝ) (hτ : 0 ≤ τ) (x : E)
    (K : ℝ) (hK : ∀ i, ‖H - B i‖ ≤ K) :
    ∀ n : ℕ, ‖Om (leakageIter B τ x n)‖ ≤ ‖Om x‖ + n * (‖Om‖ * (K * ‖x‖ * τ))
  | 0 => by simp
  | n + 1 => by
      have hxn : ‖leakageIter B τ x n‖ = ‖x‖
| 0 => by simp
  | n + 1 => by
      have hxn : ‖leakageIter B τ x n‖ = ‖x‖ := norm_leakageIter hB τ x n
      have hstep : ∀ s ∈ Set.Icc (0 : ℝ) τ,
          ‖(H - B n) (flow (B n) s (leakageIter B τ x n))‖ ≤ K * ‖x‖ := by
        intro s _
        calc ‖(H - B n) (flow (B n) s (leakageIter B τ x n))‖
            ≤ ‖H - B n‖ * ‖flow (B n) s (leakageIter B τ x n)‖ := (H - B n).le_opNorm _
          _ = ‖H - B n‖ * ‖x‖ := by rw [norm_flow_apply (hB n), hxn]
          _ ≤ K * ‖x‖ := by
              exact mul_le_mul_of_nonneg_right (hK n) (norm_nonneg x)
      have h1 := leakage_le hH hcomm τ hτ (leakageIter B τ x n) (K * ‖x‖) hstep
      have h2 := solution hH hB hcomm τ hτ x K hK n
      have : ‖Om (leakageIter B τ x (n + 1))‖
          ≤ ‖Om (leakageIter B τ x n)‖ + ‖Om‖ * (K * ‖x‖ * τ) := by
        rw [leakageIter_succ]; exact h1
      have hcast : ((n : ℝ) + 1) * (‖Om‖ * (K * ‖x‖ * τ))
          = (n : ℝ) * (‖Om‖ * (K * ‖x‖ * τ)) + ‖Om‖ * (K * ‖x‖ * τ) := by ring
      push_cast
      rw [hcast]
      linarith
