-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_add
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_add
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h₁ h₂ : X → ℝ} (hh₁ : Measurable h₁) (hh₂ : Measurable h₂)
    (d₁ : DominatedOn μ g h₁) (d₂ : DominatedOn μ g h₂) :
    mulD μ hh₁ d₁ + mulD μ hh₂ d₂ = mulD μ (hh₁.add hh₂) (d₁.add d₂) := by

  refine LinearMap.ext fun f => Subtype.ext (Lp.ext ?_)
  filter_upwards [mulD_coeFn μ hh₁ d₁ f, mulD_coeFn μ hh₂ d₂ f,
    mulD_coeFn μ (hh₁.add hh₂) (d₁.add d₂) f,
    Lp.coeFn_add ((mulD μ hh₁ d₁ f : boundedEnergyCore μ g) : Lp ℂ 2 μ)
      ((mulD μ hh₂ d₂ f : boundedEnergyCore μ g) : Lp ℂ 2 μ)] with x h1 h2 h3 h4
  simp only [LinearMap.add_apply, Submodule.coe_add]
  rw [h4]
  simp only [Pi.add_apply]
  rw [h1, h2, h3]
  push_cast
  simp only [Pi.add_apply, Complex.ofReal_add]
  ring
