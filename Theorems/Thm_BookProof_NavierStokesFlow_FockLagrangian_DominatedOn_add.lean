-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.add
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.add {μ : Measure X} {g h₁ h₂ : X → ℝ} (d₁ : DominatedOn μ g h₁)
    (d₂ : DominatedOn μ g h₂) : DominatedOn μ g (fun x => h₁ x + h₂ x) := by sorry
