-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_comp'
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_mul
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_congr
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_comp
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h₁ h₂ h : X → ℝ} (hh₁ : Measurable h₁)
    (hh₂ : Measurable h₂) (hh : Measurable h) (d₁ : DominatedOn μ g h₁)
    (d₂ : DominatedOn μ g h₂) (d : DominatedOn μ g h) (heq : ∀ x, h x = h₁ x * h₂ x) :
    (mulD μ hh₁ d₁).comp (mulD μ hh₂ d₂) = mulD μ hh d := by

  rw [mulD_comp μ hh₁ hh₂ d₁ d₂]
  exact mulD_congr μ (hh₁.mul hh₂) hh (d₁.mul d₂) d
    (Filter.Eventually.of_forall fun x => (heq x).symm)
