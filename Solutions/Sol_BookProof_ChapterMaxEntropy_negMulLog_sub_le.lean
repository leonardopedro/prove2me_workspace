-- Generated from ChapterMaxEntropy.lean — solution of BookProof.ChapterMaxEntropy.negMulLog_sub_le
import Mathlib
import Definitions.Def_ChapterMaxEntropy
open BookProof.ChapterMaxEntropy



open Real BigOperators Finset


variable {α : Type*} [Fintype α]

variable {α : Type*} [Fintype α]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hn : 0 < n) {x : ℝ} (hx : 0 ≤ x) :
    Real.negMulLog x - x * Real.log n ≤ (n : ℝ)⁻¹ - x := by

  rcases eq_or_lt_of_le hx with h | h
  · subst h; simp [Real.negMulLog]
  · have hnR : (0 : ℝ) < n := by exact_mod_cast hn
    have key : Real.negMulLog x - x * Real.log n = x * Real.log ((x * n)⁻¹) := by
      rw [Real.negMulLog, Real.log_inv, Real.log_mul (ne_of_gt h) (ne_of_gt hnR)]; ring
    rw [key]
    have hlog : Real.log ((x * n)⁻¹) ≤ (x * n)⁻¹ - 1 :=
      Real.log_le_sub_one_of_pos (by positivity)
    calc x * Real.log ((x * n)⁻¹) ≤ x * ((x * n)⁻¹ - 1) :=
              mul_le_mul_of_nonneg_left hlog hx
      _ = (n : ℝ)⁻¹ - x := by field_simp
