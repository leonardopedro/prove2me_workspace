-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian


open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockLagrangian.mulD_hasZeroDeficiencyOn (μ : Measure X) {g h : X → ℝ} (hg : Measurable g)
    (hh : Measurable h) (hdom : DominatedOn μ g h) :
    HasZeroDeficiencyOn (boundedEnergyCore μ g) (mulD μ hh hdom) := by sorry
