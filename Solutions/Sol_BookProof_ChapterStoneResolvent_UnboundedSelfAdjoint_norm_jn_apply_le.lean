-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_jn_apply_le
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_resCLM_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_jn_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_resCLM_apply_le'
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_resCLM_apply_le
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℝ) (y : H) : ‖T.jn n y‖ ≤ ‖y‖ := by

  rcases eq_or_ne n 0 with rfl | hn
  · simp [jn]
  have habs : 0 < |n| := abs_pos.mpr hn
  have h1 : ‖T.resCLM (-n) y‖ ≤ (1 / |n|) * ‖y‖ := T.norm_resCLM_apply_le' y
  have h2 : ‖T.resCLM n (T.resCLM (-n) y)‖ ≤ (1 / |n|) * ‖T.resCLM (-n) y‖ :=
    T.norm_resCLM_apply_le n _
  have h3 : ‖((n : ℂ) ^ 2)‖ = |n| ^ 2 := by
    simp [norm_pow]
  rw [jn_apply, norm_smul, h3]
  have h4 : ‖T.resCLM n (T.resCLM (-n) y)‖ ≤ (1 / |n|) * ((1 / |n|) * ‖y‖) := by
    refine h2.trans ?_
    exact mul_le_mul_of_nonneg_left h1 (by positivity)
  calc |n| ^ 2 * ‖T.resCLM n (T.resCLM (-n) y)‖
      ≤ |n| ^ 2 * ((1 / |n|) * ((1 / |n|) * ‖y‖)) := by
        exact mul_le_mul_of_nonneg_left h4 (by positivity)
    _ = ‖y‖ := by field_simp
