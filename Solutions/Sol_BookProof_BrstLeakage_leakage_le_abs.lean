-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.leakage_le_abs
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_omega_flow_eq
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_apply_le_abs
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) (x : E) (K : ℝ) (hK : ∀ s : ℝ, ‖(H - B) (flow B s x)‖ ≤ K) :
    ‖Om (flow B t x)‖ ≤ ‖Om x‖ + ‖Om‖ * (K * |t|) := by

  have hsplit : Om (flow B t x) = Om (flow H t x) + Om (flow B t x - flow H t x) := by
    rw [map_sub]; abel
  have h1 : ‖Om (flow H t x)‖ = ‖Om x‖ := norm_omega_flow_eq hH hcomm t x
  have h2 : ‖Om (flow B t x - flow H t x)‖ ≤ ‖Om‖ * (K * |t|) :=
    le_trans (Om.le_opNorm _)
      (mul_le_mul_of_nonneg_left (norm_flow_sub_flow_apply_le_abs hH t x K hK)
        (norm_nonneg Om))
  calc ‖Om (flow B t x)‖ ≤ ‖Om (flow H t x)‖ + ‖Om (flow B t x - flow H t x)‖ := by
        rw [hsplit]; exact norm_add_le _ _
    _ ≤ ‖Om x‖ + ‖Om‖ * (K * |t|) := by rw [h1]; gcongr
