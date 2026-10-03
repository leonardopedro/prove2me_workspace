-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_add
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


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_add (μ : Measure X) {g h₁ h₂ : X → ℝ} (hh₁ : Measurable h₁) (hh₂ : Measurable h₂)
    (d₁ : DominatedOn μ g h₁) (d₂ : DominatedOn μ g h₂) :
    mulD μ hh₁ d₁ + mulD μ hh₂ d₂ = mulD μ (hh₁.add hh₂) (d₁.add d₂) := by sorry
