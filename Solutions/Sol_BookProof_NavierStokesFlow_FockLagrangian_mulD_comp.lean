-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_comp
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_mul
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h₁ h₂ : X → ℝ} (hh₁ : Measurable h₁) (hh₂ : Measurable h₂)
    (d₁ : DominatedOn μ g h₁) (d₂ : DominatedOn μ g h₂) :
    (mulD μ hh₁ d₁).comp (mulD μ hh₂ d₂)
      = mulD μ (hh₁.mul hh₂) (d₁.mul d₂) := by

  refine LinearMap.ext fun f => Subtype.ext (Lp.ext ?_)
  filter_upwards [mulD_coeFn μ hh₁ d₁ (mulD μ hh₂ d₂ f), mulD_coeFn μ hh₂ d₂ f,
    mulD_coeFn μ (hh₁.mul hh₂) (d₁.mul d₂) f] with x h1 h2 h3
  simp only [LinearMap.comp_apply]
  rw [h1, h2, h3]
  push_cast
  simp only [Pi.mul_apply, Complex.ofReal_mul]
  ring
