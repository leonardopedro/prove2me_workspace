-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.tendsto_unitaryU_zero
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_unitaryU_apply
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_unitaryU_sub_of_mem
import Theorems.Thm_BookProof_NonnegResolvent_dense_domain
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : F) :
    Tendsto (fun t : ℝ => unitaryU hT hsv t x) (𝓝 0) (𝓝 x) := by

  rw [Metric.tendsto_nhds_nhds]
  intro ε hε
  obtain ⟨z, hz, hxz⟩ := (dense_domain hT hsv).exists_dist_lt x (ε := ε / 3) (by linarith)
  obtain ⟨p, hp, hp1⟩ := Submodule.mem_map.1 hz
  have hpz : (z, p.2) ∈ T := by
    have hpe : p = (z, p.2) := by
      rw [← hp1]
      simp
    rwa [← hpe]
  refine ⟨ε / (3 * (‖p.2‖ + 1)), by positivity, fun t ht => ?_⟩
  rw [Real.dist_eq, sub_zero] at ht
  have hzx : ‖x - z‖ < ε / 3 := by rw [dist_eq_norm] at hxz; exact hxz
  have h1 : ‖unitaryU hT hsv t (x - z)‖ = ‖x - z‖ := norm_unitaryU_apply hT hsv t _
  have h2 : ‖unitaryU hT hsv t z - z‖ ≤ |t| * ‖p.2‖ := norm_unitaryU_sub_of_mem hT hsv hpz t
  have hsplit : unitaryU hT hsv t x - x
      = unitaryU hT hsv t (x - z) + (unitaryU hT hsv t z - z) + (z - x) := by
    rw [map_sub]
    abel
  have h3 : |t| * ‖p.2‖ < ε / 3 := by
    have hden : (0 : ℝ) < 3 * (‖p.2‖ + 1) := by positivity
    have h4 : |t| * (3 * (‖p.2‖ + 1)) < ε := by
      rw [← lt_div_iff₀ hden]; exact ht
    nlinarith [norm_nonneg p.2, abs_nonneg t]
  rw [dist_eq_norm]
  calc ‖unitaryU hT hsv t x - x‖
      ≤ ‖unitaryU hT hsv t (x - z)‖ + ‖unitaryU hT hsv t z - z‖ + ‖z - x‖ := by
        rw [hsplit]
        exact (norm_add_le _ _).trans (by gcongr; exact norm_add_le _ _)
    _ < ε := by
        rw [h1, norm_sub_rev z x]
        linarith [h2.trans_lt h3]
