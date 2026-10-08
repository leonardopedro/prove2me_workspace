-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_eq_zero_of_eigen
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


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_eq_zero_of_eigen (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) {lam : ℂ} (hlevel : μ {x | (h x : ℂ) = lam} = 0)
    (v : boundedEnergyCore μ g)
    (hv : ((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ)
        = lam • ((v : Lp ℂ 2 μ))) :
    ((v : Lp ℂ 2 μ)) = 0 := by sorry
