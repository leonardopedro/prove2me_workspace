-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_congr
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h₁ h₂ : X → ℝ} (hh₁ : Measurable h₁) (hh₂ : Measurable h₂)
    (d₁ : DominatedOn μ g h₁) (d₂ : DominatedOn μ g h₂) (hae : h₁ =ᵐ[μ] h₂) :
    mulD μ hh₁ d₁ = mulD μ hh₂ d₂ := by

  refine LinearMap.ext fun f => Subtype.ext (Lp.ext ?_)
  filter_upwards [mulD_coeFn μ hh₁ d₁ f, mulD_coeFn μ hh₂ d₂ f, hae] with x h1 h2 h3
  rw [h1, h2, h3]
