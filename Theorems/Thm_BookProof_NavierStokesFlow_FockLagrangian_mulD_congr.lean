-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_congr
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_congr (μ : Measure X) {g h₁ h₂ : X → ℝ} (hh₁ : Measurable h₁) (hh₂ : Measurable h₂)
    (d₁ : DominatedOn μ g h₁) (d₂ : DominatedOn μ g h₂) (hae : h₁ =ᵐ[μ] h₂) :
    mulD μ hh₁ d₁ = mulD μ hh₂ d₂ := by sorry
