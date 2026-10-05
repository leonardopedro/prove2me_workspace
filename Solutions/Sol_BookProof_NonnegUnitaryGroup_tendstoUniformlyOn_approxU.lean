-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.tendstoUniformlyOn_approxU
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_unitaryU_apply
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_unitaryU_sub_approxU_le
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_approxU_apply
import Theorems.Thm_BookProof_NonnegResolvent_dense_domain
import Theorems.Thm_BookProof_NonnegResolvent_tendsto_yosidaAt
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (z : F) (R : ℝ) :
    TendstoUniformlyOn (fun (n : ℕ) (t : ℝ) => approxU hT n t z)
      (fun t : ℝ => unitaryU hT hsv t z) atTop {t : ℝ | |t| ≤ R} := by

  rw [Metric.tendstoUniformlyOn_iff]
  intro ε hε
  obtain ⟨y, hy, hzy⟩ := (dense_domain hT hsv).exists_dist_lt z (ε := ε / 3) (by linarith)
  obtain ⟨p, hp, hp1⟩ := Submodule.mem_map.1 hy
  have hpy : (y, p.2) ∈ T := by
    have hpe : p = (y, p.2) := by
      rw [← hp1]
      simp
    rwa [← hpe]
  set R' : ℝ := max R 0 with hR'
  have hR'0 : (0 : ℝ) ≤ R' := le_max_right _ _
  have hten : Tendsto (fun n : ℕ => ‖p.2 - yosidaAt hT n y‖) atTop (𝓝 0) := by
    have h := (tendsto_const_nhds (x := p.2) (f := atTop (α := ℕ))).sub
      (tendsto_yosidaAt hT hsv hpy)
    simpa using h.norm
  have hev : ∀ᶠ n : ℕ in atTop, ‖p.2 - yosidaAt hT n y‖ < ε / (3 * (R' + 1)) := by
    have hpos : (0 : ℝ) < ε / (3 * (R' + 1)) := by positivity
    obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hten _ hpos
    filter_upwards [eventually_ge_atTop N] with n hn
    simpa [Real.dist_eq, abs_of_nonneg (norm_nonneg _)] using hN n hn
  filter_upwards [hev] with n hn t ht
  have htR : |t| ≤ R' := le_trans ht (le_max_left _ _)
  have hsplit : unitaryU hT hsv t z - approxU hT n t z
      = unitaryU hT hsv t (z - y) + (unitaryU hT hsv t y - approxU hT n t y)
        + approxU hT n t (y - z) := by
    rw [map_sub, map_sub]
    abel
  have h1 : ‖unitaryU hT hsv t (z - y)‖ = ‖z - y‖ := norm_unitaryU_apply hT hsv t _
  have h2 : ‖approxU hT n t (y - z)‖ = ‖y - z‖ := norm_approxU_apply hT n t _
  have h3 : ‖unitaryU hT hsv t y - approxU hT n t y‖ ≤ |t| * ‖p.2 - yosidaAt hT n y‖ :=
    norm_unitaryU_sub_approxU_le hT hsv hpy n t
  have h4 : |t| * ‖p.2 - yosidaAt hT n y‖ < ε / 3 := by
    have hR1 : (0 : ℝ) < R' + 1 := by linarith
    calc |t| * ‖p.2 - yosidaAt hT n y‖ ≤ (R' + 1) * ‖p.2 - yosidaAt hT n y‖ := by
          gcongr
          linarith
      _ < (R' + 1) * (ε / (3 * (R' + 1))) := mul_lt_mul_of_pos_left hn hR1
      _ = ε / 3 := by field_simp
  have hzy' : ‖z - y‖ < ε / 3 := by rw [dist_eq_norm] at hzy; exact hzy
  rw [dist_eq_norm]
  calc ‖unitaryU hT hsv t z - approxU hT n t z‖
      ≤ ‖unitaryU hT hsv t (z - y)‖ + ‖unitaryU hT hsv t y - approxU hT n t y‖
          + ‖approxU hT n t (y - z)‖ := by
        rw [hsplit]
        exact (norm_add_le _ _).trans (by gcongr; exact norm_add_le _ _)
    _ < ε := by
        rw [h1, h2, norm_sub_rev y z]
        linarith [h3.trans_lt h4]
