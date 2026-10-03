-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_not_bounded (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h)
    (H : ∀ K : ℝ, ∃ v : boundedEnergyCore μ g, ‖((v : Lp ℂ 2 μ))‖ = 1 ∧
      ∀ᵐ x ∂μ, ((v : Lp ℂ 2 μ) : X → ℂ) x ≠ 0 → K ≤ |h x|) :
    ¬ ∃ C : ℝ, ∀ v : boundedEnergyCore μ g,
      ‖((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ)‖ ≤ C * ‖((v : Lp ℂ 2 μ))‖ := by sorry
