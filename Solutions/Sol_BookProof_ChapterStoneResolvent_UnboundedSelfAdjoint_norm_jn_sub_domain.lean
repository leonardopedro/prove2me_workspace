-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_jn_sub_domain
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_resCLM_apply_le'
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_jn_apply_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_resCLM_apply_le
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℝ} (hn : n ≠ 0) (x : T.domain) :
    ‖T.jn n (x : H) - (x : H)‖ ≤ 2 * ‖T.op x‖ / |n| := by

  have habs : 0 < |n| := abs_pos.mpr hn
  have hid : T.jn n (x : H) - (x : H)
      = -T.resCLM n (T.op x) + ((n : ℂ) * Complex.I) • T.resCLM n (T.resCLM (-n) (T.op x)) := by
    rw [T.jn_apply_domain hn x]; abel
  have h1 : ‖T.resCLM n (T.op x)‖ ≤ ‖T.op x‖ / |n| := by
    have := T.norm_resCLM_apply_le n (T.op x)
    rw [div_eq_inv_mul]
    simpa [one_div] using this
  have h2 : ‖((n : ℂ) * Complex.I) • T.resCLM n (T.resCLM (-n) (T.op x))‖ ≤ ‖T.op x‖ / |n| := by
    rw [norm_smul]
    have hc : ‖(n : ℂ) * Complex.I‖ = |n| := by simp
    have ha : ‖T.resCLM n (T.resCLM (-n) (T.op x))‖ ≤ (1 / |n|) * ((1 / |n|) * ‖T.op x‖) := by
      refine (T.norm_resCLM_apply_le n _).trans ?_
      exact mul_le_mul_of_nonneg_left (T.norm_resCLM_apply_le' (T.op x)) (by positivity)
    rw [hc]
    calc |n| * ‖T.resCLM n (T.resCLM (-n) (T.op x))‖
        ≤ |n| * ((1 / |n|) * ((1 / |n|) * ‖T.op x‖)) :=
          mul_le_mul_of_nonneg_left ha (le_of_lt habs)
      _ = ‖T.op x‖ / |n| := by field_simp
  calc ‖T.jn n (x : H) - (x : H)‖
      ≤ ‖-T.resCLM n (T.op x)‖
        + ‖((n : ℂ) * Complex.I) • T.resCLM n (T.resCLM (-n) (T.op x))‖ := by
        rw [hid]; exact norm_add_le _ _
    _ ≤ ‖T.op x‖ / |n| + ‖T.op x‖ / |n| := by
        rw [norm_neg]; exact add_le_add h1 h2
    _ = 2 * ‖T.op x‖ / |n| := by ring
