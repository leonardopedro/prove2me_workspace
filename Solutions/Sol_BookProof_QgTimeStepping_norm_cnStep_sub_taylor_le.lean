-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_cnStep_sub_taylor_le
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_two_div_ne_zero
import Theorems.Thm_BookProof_QgTimeStepping_cnStep_second_order




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {tau : ℝ} (htau : 0 < tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)‖
      ≤ tau ^ 2 / 2 * ‖T.op ⟨T.op x, hx⟩‖ := by

  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero (ne_of_gt htau)
  have hrb := T.norm_res_le (2 / tau) (T.op ⟨T.op x, hx⟩)
  have habs : |2 / tau| = 2 / tau := abs_of_pos (by positivity)
  rw [cnStep_second_order T (ne_of_gt htau) x hx]
  have heq : (x : H) - ((tau : ℂ) * Complex.I) • T.op x
        + ((tau : ℂ) * Complex.I) • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H)
      - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)
      = ((tau : ℂ) * Complex.I) • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by
    abel
  rw [heq, norm_smul]
  have hns : ‖((tau : ℝ) : ℂ) * Complex.I‖ = tau := by
    simp [abs_of_pos htau]
  rw [hns]
  rw [habs] at hrb
  have h2 : ‖((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H)‖
      ≤ 1 / (2 / tau) * ‖T.op ⟨T.op x, hx⟩‖ := hrb
  have hpos : (0 : ℝ) < 2 / tau := by positivity
  have hkey : 1 / (2 / tau) = tau / 2 := by field_simp
  rw [hkey] at h2
  calc tau * ‖((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H)‖
      ≤ tau * (tau / 2 * ‖T.op ⟨T.op x, hx⟩‖) := by
        exact mul_le_mul_of_nonneg_left h2 (le_of_lt htau)
    _ = tau ^ 2 / 2 * ‖T.op ⟨T.op x, hx⟩‖ := by ring
