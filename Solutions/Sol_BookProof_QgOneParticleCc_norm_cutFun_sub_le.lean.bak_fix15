-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.norm_cutFun_sub_le
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_cut_mem_Icc
import Theorems.Thm_BookProof_QgOneParticleCc_sum_norm_coreD_nonneg
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
theorem solution (W : Vd d → ℝ) {K R : ℝ} (hK1 : 1 ≤ K)
    (p : MvPolynomial (Fin d) ℂ) (z : Vd d) :
    ‖cutFun R p z - pgFun p z‖ ≤ majorant W K p z := by

  obtain ⟨hc0, hc1⟩ := cut_mem_Icc (d := d) (R := R) z
  have hfac : cutFun R p z - pgFun p z = (((cut d R z - 1 : ℝ)) : ℂ) * pgFun p z := by
    simp only [cutFun]
    push_cast
    ring
  have hle : ‖cutFun R p z - pgFun p z‖ ≤ ‖pgFun p z‖ := by
    rw [hfac, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    have habs : |cut d R z - 1| ≤ 1 := by rw [abs_le]; constructor <;> linarith
    nlinarith [norm_nonneg (pgFun p z)]
  have hK0 : (0 : ℝ) ≤ K := by linarith
  have hrest : 0 ≤ 2 * K * (∑ j : Fin d, ‖pgFun (coreD j p) z‖) :=
    mul_nonneg (by linarith) (sum_norm_coreD_nonneg p z)
  have hKmul : ‖pgFun p z‖ ≤ K * ‖pgFun p z‖ := by nlinarith [norm_nonneg (pgFun p z)]
  rw [majorant]
  have hn1 : 0 ≤ ‖pgFun (kinPoly p) z‖ := norm_nonneg _
  have hn2 : 0 ≤ ‖((W z : ℝ) : ℂ) * pgFun p z‖ := norm_nonneg _
  linarith
