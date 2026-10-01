-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.hasDerivAt_stoneU_zero
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_sub_smul_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_sub_approxU_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_tendsto
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
 (Set.right_mem_uIcc)
  have hg0 : g 0 = 0 := by simp [hg]
  rw [hg0, sub_zero, sub_zero, Real.norm_eq_abs] at hmvt
  exact hmvt

/-- **Stone's equation at `t = 0`**: the generator of `e^{-itA}` is `-iA`. :=
  -/
  theorem hasDerivAt_stoneU_zero (x : T.domain) :
      HasDerivAt (fun t : ℝ => T.stoneU t (x : H)) ((-Complex.I) • T.op x) 0 := by
    set w : H := (-Complex.I) • T.op x with hw
    rw [hasDerivAt_iff_isLittleO_nhds_zero, Asymptotics.isLittleO_iff]
    intro c hc
    -- choose an approximation index `k` with `‖A x - A_k x‖` small
    obtain ⟨k, hk⟩ : ∃ k : ℕ, ‖T.op x - T.yosida ((k : ℝ) + 1) (x : H)‖ < c / 4 := by
      have h := (T.yosida_tendsto x)
      have := Metric.tendsto_atTop.mp h (c / 4) (by linarith)
      obtain ⟨N, hN⟩ := this
      exact ⟨N, by
        have := hN N le_rfl
        rwa [dist_eq_norm, norm_sub_rev] at this⟩
    set n : ℝ := (k : ℝ) + 1 with hn
    set M : ℝ := ‖T.yosida n (T.yosidaGen n (x : H))‖ with hM
    have hMpos : (0 : ℝ) < M + 1 := by positivity
    set δ : ℝ := (c / 4) / (M + 1) with hδ
    have hδpos : 0 < δ := by positivity
    filter_upwards [Metric.ball_mem_nhds (0 : ℝ) hδpos] with h hh
    rw [Metric.mem_ball, Real.dist_eq, sub_zero] at hh
    have habs : |h| < δ := hh
    -- three-term estimate
    have e1 : ‖T.stoneU h (x : H) - T.approxU n h (x : H)‖
        ≤ |h| * ‖T.op x - T.yosida n (x : H)‖ := T.norm_stoneU_sub_approxU_le n h x
    have e2 : ‖T.approxU n h (x : H) - (x : H) - h • T.yosidaGen n (x : H)‖ ≤ (|h| * M) * |h| :=
      T.norm_approxU_sub_smul_le n h (x : H)
    have e3 : ‖h • T.yosidaGen n (x : H) - h • w‖ = |h| * ‖T.op x - T.yosida n (x : H)‖ := by
      rw [← smul_sub, norm_smul, Real.norm_eq_abs]
      congr 1
      have hstep : T.yosidaGen n (x : H) - w = (-Complex.I) • (T.yosida n (x : H) - T.op x) := by
        rw [hw, yosidaGen]
        simp [smul_sub]
      rw [hstep, norm_smul]
      simp [norm_sub_rev]
    have hsplit : T.stoneU h (x : H) - (x : H) - h • w
        = (T.stoneU h (x : H) - T.approxU n h (x : H))
          + (T.approxU n h (x : H) - (x : H) - h • T.yosidaGen n (x : H))
          + (h • T.yosidaGen n (x : H) - h • w) := by
      abel
    have hMbound : |h| * M ≤ c / 4 := by
      have h1 : |h| * (M + 1) < c / 4 := by
        rw [hδ] at habs
        rw [← lt_div_iff₀ hMpos]
        exact habs
      nlinarith [abs_nonneg h, norm_nonneg (T.yosida n (T.yosidaGen n (x : H)))]
    have hfinal : ‖T.stoneU h (x : H) - (x : H) - h • w‖ ≤ c * ‖h‖ := by
      have hc4 : ‖T.op x - T.yosida n (x : H)‖ ≤ c / 4 := le_of_lt hk
      have hb1 : ‖T.stoneU h (x : H) - T.approxU n h (x : H)‖ ≤ |h| * (c / 4) :=
        e1.trans (mul_le_mul_of_nonneg_left hc4 (abs_nonneg h))
      have hb2 : ‖T.approxU n h (x : H) - (x : H) - h • T.yosidaGen n (x : H)‖ ≤ (c / 4) * |h| :=
        e2.trans (mul_le_mul_of_nonneg_right hMbound (abs_nonneg h))
      have hb3 : ‖h • T.yosidaGen n (x : H) - h • w‖ ≤ |h| * (c / 4) := by
        rw [e3]
        exact mul_le_mul_of_nonneg_left hc4 (abs_nonneg h)
      calc ‖T.stoneU h (x : H) - (x : H) - h • w‖
          ≤ ‖T.stoneU h (x : H) - T.approxU n h (x : H)‖
            + ‖T.approxU n h (x : H) - (x : H) - h • T.yosidaGen n (x : H)‖
            + ‖h • T.yosidaGen n (x : H) - h • w‖ := by
            rw [hsplit]
            exact (norm_add_le _ _).trans (by gcongr; exact norm_add_le _ _)
        _ ≤ |h| * (c / 4) + (c / 4) * |h| + |h| * (c / 4) := by
            exact add_le_add (add_le_add
