-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.tendsto_stoneU_zero
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_sub_domain
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (x : H) : Tendsto (fun t : ℝ => T.stoneU t x) (𝓝 0) (𝓝 x) := by

  rw [Metric.tendsto_nhds_nhds]
  intro ε hε
  obtain ⟨z, hz, hxz⟩ := T.denseDomain.exists_dist_lt x (ε := ε / 3) (by linarith)
  set w : T.domain := ⟨z, hz⟩ with hw
  refine ⟨ε / (3 * (‖T.op w‖ + 1)), by positivity, fun t ht => ?_⟩
  rw [Real.dist_eq, sub_zero] at ht
  have hzx : ‖x - z‖ < ε / 3 := by rw [dist_eq_norm] at hxz; exact hxz
  have h1 : ‖T.stoneU t (x - z)‖ = ‖x - z‖ := T.norm_stoneU_apply t _
  have h2 : ‖T.stoneU t z - z‖ ≤ |t| * ‖T.op w‖ := T.norm_stoneU_sub_domain t w
  have hsplit : T.stoneU t x - x = T.stoneU t (x - z) + (T.stoneU t z - z) + (z - x) := by
    rw [map_sub]
    abel
  have h3 : |t| * ‖T.op w‖ < ε / 3 := by
    have hden : (0 : ℝ) < 3 * (‖T.op w‖ + 1) := by positivity
    have h4 : |t| * (3 * (‖T.op w‖ + 1)) < ε := by
      rw [← lt_div_iff₀ hden]; exact ht
    nlinarith [norm_nonneg (T.op w), abs_nonneg t]
  rw [dist_eq_norm]
  calc ‖T.stoneU t x - x‖
      ≤ ‖T.stoneU t (x - z)‖ + ‖T.stoneU t z - z‖ + ‖z - x‖ := by
        rw [hsplit]
        exact (norm_add_le _ _).trans (by gcongr; exact norm_add_le _ _)
    _ < ε := by
        rw [h1, norm_sub_rev z x]
        linarith [h2.trans_lt h3]
