-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.const
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.const (μ : Measure X) (g : X → ℝ) (r : ℝ) :
    DominatedOn μ g (fun _ => r) := by sorry
