-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_add'
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_add_prime (μ : Measure X) {g h₁ h₂ h : X → ℝ} (hh₁ : Measurable h₁)
    (hh₂ : Measurable h₂) (hh : Measurable h) (d₁ : DominatedOn μ g h₁)
    (d₂ : DominatedOn μ g h₂) (d : DominatedOn μ g h) (heq : ∀ x, h x = h₁ x + h₂ x) :
    mulD μ hh₁ d₁ + mulD μ hh₂ d₂ = mulD μ hh d := by sorry
