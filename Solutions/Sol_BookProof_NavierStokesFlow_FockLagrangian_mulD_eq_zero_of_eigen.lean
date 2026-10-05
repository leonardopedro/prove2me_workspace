-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_eq_zero_of_eigen
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) {lam : ℂ} (hlevel : μ {x | (h x : ℂ) = lam} = 0)
    (v : boundedEnergyCore μ g)
    (hv : ((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ)
        = lam • ((v : Lp ℂ 2 μ))) :
    ((v : Lp ℂ 2 μ)) = 0 := by

  have hae : ∀ᵐ x ∂μ, x ∉ {x | (h x : ℂ) = lam} := measure_eq_zero_iff_ae_notMem.1 hlevel
  have h1 : (((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ) : X → ℂ)
      =ᵐ[μ] ((lam • (v : Lp ℂ 2 μ) : Lp ℂ 2 μ) : X → ℂ) := by rw [hv]
  refine Lp.ext ?_
  filter_upwards [hae, mulD_coeFn μ hh hdom v, Lp.coeFn_smul lam ((v : Lp ℂ 2 μ)), h1,
    Lp.coeFn_zero (E := ℂ) (p := 2) (μ := μ)] with x hx hmul hsm heq hz
  rw [hz]
  rw [hmul, hsm] at heq
  simp only [Pi.smul_apply, smul_eq_mul] at heq
  by_contra hv0
  exact hx (mul_right_cancel₀ hv0 heq)
