-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.norm_cutErr_le
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_cut_mem_Icc
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) {C K R : ℝ} (hC0 : 0 ≤ C) (hCK : C ≤ K) (hR1 : 1 ≤ R)
    (p : MvPolynomial (Fin d) ℂ) (z : Vd d)
    (hd1 : ∀ j : Fin d, ‖dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z‖ ≤ C / R)
    (hd2 : ‖lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z‖ ≤ C / R ^ 2) :
    ‖cutErr W R p z‖ ≤ majorant W K p z := by

  have hRpos : (0 : ℝ) < R := lt_of_lt_of_le zero_lt_one hR1
  have hCRK : C / R ≤ K := by
    have h : C / R ≤ C := by
      rw [div_le_iff₀ hRpos]
      nlinarith
    linarith
  have hCR2K : C / R ^ 2 ≤ K := by
    have hR2 : (1 : ℝ) ≤ R ^ 2 := by nlinarith
    have h : C / R ^ 2 ≤ C := by
      rw [div_le_iff₀ (by positivity)]
      nlinarith
    linarith
  obtain ⟨hc0, hc1⟩ := cut_mem_Icc (d := d) (R := R) z
  have habs : |cut d R z - 1| ≤ 1 := by rw [abs_le]; constructor <;> linarith
  have hcoe : ((cut d R z : ℝ) : ℂ) - 1 = (((cut d R z - 1 : ℝ)) : ℂ) := by push_cast; ring
  set e1 : ℂ := (((cut d R z : ℝ) : ℂ) - 1) * pgFun (kinPoly p) z with he1
  set e2 : ℂ := pgFun p z * lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z with he2
  set e3 : ℂ := 2 * ∑ j : Fin d,
      dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z * pgFun (coreD j p) z with he3
  set e4 : ℂ := (((cut d R z : ℝ) : ℂ) - 1) * (((W z : ℝ) : ℂ) * pgFun p z) with he4
  have hsplit : ‖e1 - e2 - e3 + e4‖ ≤ ‖e1‖ + ‖e2‖ + ‖e3‖ + ‖e4‖ := by
    have s1 := norm_add_le (e1 - e2 - e3) e4
    have s2 := norm_sub_le (e1 - e2) e3
    have s3 := norm_sub_le e1 e2
    linarith
  have hb1 : ‖e1‖ ≤ ‖pgFun (kinPoly p) z‖ := by
    rw [he1, hcoe, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    nlinarith [norm_nonneg (pgFun (kinPoly p) z)]
  have hb2 : ‖e2‖ ≤ K * ‖pgFun p z‖ := by
    rw [he2, norm_mul]
    have h := mul_le_mul_of_nonneg_left (le_trans hd2 hCR2K) (norm_nonneg (pgFun p z))
    calc ‖pgFun p z‖ * ‖lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z‖
        ≤ ‖pgFun p z‖ * K := h
      _ = K * ‖pgFun p z‖ := by ring
  have hb3 : ‖e3‖ ≤ 2 * K * (∑ j : Fin d, ‖pgFun (coreD j p) z‖) := by
    have hinner : ‖∑ j : Fin d,
        dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z * pgFun (coreD j p) z‖
          ≤ ∑ j : Fin d, K * ‖pgFun (coreD j p) z‖ := by
      refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun j _ => ?_)
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right (le_trans (hd1 j) hCRK) (norm_nonneg _)
    rw [← Finset.mul_sum] at hinner
    rw [he3, norm_mul]
    have h2c : ‖(2 : ℂ)‖ = 2 := by norm_num
    rw [h2c]
    nlinarith [sum_norm_coreD_nonneg p z]
  have hb4 : ‖e4‖ ≤ ‖((W z : ℝ) : ℂ) * pgFun p z‖ := by
    rw [he4, hcoe, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    nlinarith [norm_nonneg (((W z : ℝ) : ℂ) * pgFun p z)]
  have hgoal : cutErr W R p z = e1 - e2 - e3 + e4 := rfl
  rw [hgoal, majorant]
  linarith
