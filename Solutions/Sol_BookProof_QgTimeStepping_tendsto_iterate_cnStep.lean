-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.tendsto_iterate_cnStep
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_iterate_cnStep_sub
import Theorems.Thm_BookProof_QgTimeStepping_norm_iterate_cnStep_apply
import Theorems.Thm_BookProof_QgTimeStepping_norm_iterate_cnStep_sub_stoneU_le
import Theorems.Thm_BookProof_QgTimeStepping_exists_domain_two_approx
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {t : ℝ} (ht : 0 < t) (v : H) :
    Tendsto (fun k : ℕ => (cnStep T (t / (k + 1)))^[k + 1] v) atTop
      (𝓝 (T.stoneU t v)) := by

  rw [Metric.tendsto_atTop]
  intro eps heps
  obtain ⟨x, hx, hvx⟩ := exists_domain_two_approx T v (eps := eps / 4) (by linarith)
  set Mv : ℝ := ‖T.op ⟨T.op x, hx⟩‖ with hMv
  have hMv0 : 0 ≤ Mv := norm_nonneg _
  obtain ⟨N, hN⟩ := exists_nat_gt (8 * t ^ 2 * Mv / eps)
  refine ⟨N, fun k hk => ?_⟩
  set tau : ℝ := t / ((k : ℝ) + 1) with htau
  have hk1 : (0 : ℝ) < (k : ℝ) + 1 := by positivity
  have htaupos : 0 < tau := by positivity
  have hkt : ((k : ℕ) + 1 : ℝ) * tau = t := by
    rw [htau]
    field_simp
  have hglob := norm_iterate_cnStep_sub_stoneU_le T htaupos (k + 1) x hx
  have hcast : (((k + 1 : ℕ)) : ℝ) = (k : ℝ) + 1 := by push_cast; ring
  rw [hcast, hkt] at hglob
  have hbnd : 2 * ((k : ℝ) + 1) * tau ^ 2 * Mv = 2 * t ^ 2 * Mv / ((k : ℝ) + 1) := by
    rw [htau, div_pow]
    field_simp
  rw [hbnd] at hglob
  have hsmall : 2 * t ^ 2 * Mv / ((k : ℝ) + 1) < eps / 2 := by
    have hNk : (N : ℝ) ≤ (k : ℝ) := Nat.cast_le.mpr hk
    have h1 : 8 * t ^ 2 * Mv / eps < (k : ℝ) + 1 := by linarith
    have h2 : 8 * t ^ 2 * Mv < ((k : ℝ) + 1) * eps := by
      rw [div_lt_iff₀ heps] at h1
      linarith
    rw [div_lt_iff₀ hk1]
    nlinarith
  have h1 : ‖(cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H)‖ < eps / 4 := by
    rw [iterate_cnStep_sub T tau, norm_iterate_cnStep_apply T (ne_of_gt htaupos)]
    exact hvx
  have h3 : ‖T.stoneU t (x : H) - T.stoneU t v‖ < eps / 4 := by
    rw [← map_sub, T.norm_stoneU_apply, norm_sub_rev]
    exact hvx
  have hsplit : (cnStep T tau)^[k + 1] v - T.stoneU t v
      = ((cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H))
        + ((cnStep T tau)^[k + 1] (x : H) - T.stoneU t (x : H))
        + (T.stoneU t (x : H) - T.stoneU t v) := by
    abel
  have htri := norm_add_le
    (((cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H))
      + ((cnStep T tau)^[k + 1] (x : H) - T.stoneU t (x : H)))
    (T.stoneU t (x : H) - T.stoneU t v)
  have htri2 := norm_add_le ((cnStep T tau)^[k + 1] v - (cnStep T tau)^[k + 1] (x : H))
    ((cnStep T tau)^[k + 1] (x : H) - T.stoneU t (x : H))
  rw [dist_eq_norm, hsplit]
  linarith
