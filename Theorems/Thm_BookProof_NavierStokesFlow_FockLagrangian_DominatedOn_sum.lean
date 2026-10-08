-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow


open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]


theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.sum {ι : Type*} {μ : Measure X} {g : X → ℝ} (s : Finset ι)
    {h : ι → X → ℝ} (d : ∀ i ∈ s, DominatedOn μ g (h i)) :
    DominatedOn μ g (fun x => ∑ i ∈ s, h i x) := by sorry
