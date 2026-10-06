-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.norm_mulD_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) (v : boundedEnergyCore μ g) {K : ℝ} (hK : 0 ≤ K)
    (hge : ∀ᵐ x ∂μ, ((v : Lp ℂ 2 μ) : X → ℂ) x ≠ 0 → K ≤ |h x|) :
    K * ‖((v : Lp ℂ 2 μ))‖ ≤ ‖((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ)‖ := by

  have hsmul : ‖((K : ℂ) • (v : Lp ℂ 2 μ))‖ = K * ‖((v : Lp ℂ 2 μ))‖ := by
    rw [norm_smul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hK]
  rw [← hsmul]
  refine Lp.norm_le_norm_of_ae_le ?_
  filter_upwards [hge, mulD_coeFn μ hh hdom v,
    Lp.coeFn_smul ((K : ℂ)) ((v : Lp ℂ 2 μ))] with x hx hmul hsm
  rw [hsm, hmul]
  simp only [Pi.smul_apply, smul_eq_mul, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  by_cases hv : ((v : Lp ℂ 2 μ) : X → ℂ) x = 0
  · rw [hv]; simp
  · exact mul_le_mul_of_nonneg_right (by rw [abs_of_nonneg hK]; exact hx hv) (norm_nonneg _)
