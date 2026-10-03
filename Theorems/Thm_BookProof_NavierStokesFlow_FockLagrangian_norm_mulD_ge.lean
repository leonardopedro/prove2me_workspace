-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.norm_mulD_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.norm_mulD_ge (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) (v : boundedEnergyCore μ g) {K : ℝ} (hK : 0 ≤ K)
    (hge : ∀ᵐ x ∂μ, ((v : Lp ℂ 2 μ) : X → ℂ) x ≠ 0 → K ≤ |h x|) :
    K * ‖((v : Lp ℂ 2 μ))‖ ≤ ‖((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ)‖ := by sorry
