-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_real_smul'
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian


open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_real_smul_prime (μ : Measure X) {g h₁ h : X → ℝ} (r : ℝ) (hh₁ : Measurable h₁)
    (hh : Measurable h) (d₁ : DominatedOn μ g h₁) (d : DominatedOn μ g h)
    (heq : ∀ x, h x = r * h₁ x) :
    ((r : ℝ) : ℂ) • mulD μ hh₁ d₁ = mulD μ hh d := by sorry
