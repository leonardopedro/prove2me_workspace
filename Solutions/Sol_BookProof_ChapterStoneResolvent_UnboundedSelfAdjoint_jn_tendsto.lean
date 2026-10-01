-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.jn_tendsto
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_jn_apply_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_jn_sub_domain
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (y : H) :
    Tendsto (fun k : ℕ => T.jn ((k : ℝ) + 1) y) atTop (𝓝 y) := by

  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨z, hz, hdist⟩ := T.denseDomain.exists_dist_lt y (ε := ε / 3) (by linarith)
  set x : T.domain := ⟨z, hz⟩ with hx
  obtain ⟨N, hN⟩ := exists_nat_gt (6 * ‖T.op x‖ / ε)
  refine ⟨N, fun k hk => ?_⟩
  have hpos : (0 : ℝ) < (k : ℝ) + 1 := by positivity
  have hn : ((k : ℝ) + 1) ≠ 0 := ne_of_gt hpos
  have habs : |(k : ℝ) + 1| = (k : ℝ) + 1 := abs_of_pos hpos
  have hyz : ‖y - z‖ < ε / 3 := by
    rw [dist_eq_norm] at hdist; exact hdist
  have hkey : ‖T.jn ((k : ℝ) + 1) (x : H) - (x : H)‖ ≤ 2 * ‖T.op x‖ / ((k : ℝ) + 1) := by
    have := T.norm_jn_sub_domain hn x
    rwa [habs] at this
  have hklarge : 2 * ‖T.op x‖ / ((k : ℝ) + 1) < ε / 3 := by
    rw [div_lt_iff₀ hpos]
    have hNk : (6 * ‖T.op x‖ / ε) < (k : ℝ) + 1 := by
      have : (N : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
      linarith
    have h6 : 6 * ‖T.op x‖ < ε * ((k : ℝ) + 1) := by
      rw [div_lt_iff₀ hε] at hNk
      linarith
    linarith
  have hsplit : T.jn ((k : ℝ) + 1) y - y
      = T.jn ((k : ℝ) + 1) (y - z) + (T.jn ((k : ℝ) + 1) (x : H) - (x : H)) + (z - y) := by
    have : T.jn ((k : ℝ) + 1) (y - z) = T.jn ((k : ℝ) + 1) y - T.jn ((k : ℝ) + 1) z := by
      rw [map_sub]
    rw [this]
    simp only [hx]
    abel
  have hb1 : ‖T.jn ((k : ℝ) + 1) (y - z)‖ ≤ ‖y - z‖ := T.norm_jn_apply_le _ _
  have hb3 : ‖z - y‖ = ‖y - z‖ := norm_sub_rev z y
  rw [dist_eq_norm]
  calc ‖T.jn ((k : ℝ) + 1) y - y‖
      ≤ ‖T.jn ((k : ℝ) + 1) (y - z)‖ + ‖T.jn ((k : ℝ) + 1) (x : H) - (x : H)‖ + ‖z - y‖ := by
        rw [hsplit]
        exact (norm_add_le _ _).trans (by gcongr; exact norm_add_le _ _)
    _ < ε / 3 + ε / 3 + ε / 3 := by
        rw [hb3]
        have := hkey.trans_lt hklarge
        linarith [hb1.trans_lt hyz]
    _ = ε := by ring
