-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.norm_le_of_inner_self_bound
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution {y : H} {C : ℝ} (hC : 0 ≤ C)
    (h : ‖⟪y, y⟫_ℂ‖ ≤ C * ‖y‖) : ‖y‖ ≤ C := by

  have hn : ‖⟪y, y⟫_ℂ‖ = ‖y‖ * ‖y‖ := by
    rw [inner_self_eq_norm_sq_to_K]
    simp [sq]
  rw [hn] at h
  rcases eq_or_lt_of_le (norm_nonneg y) with h0 | h0
  · rw [← h0]; exact hC
  · exact le_of_mul_le_mul_right (by linarith) h0
