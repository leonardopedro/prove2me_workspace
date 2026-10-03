-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.const_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.DominatedOn.const_mul {μ : Measure X} {g h : X → ℝ} (r : ℝ) (d : DominatedOn μ g h) :
    DominatedOn μ g (fun x => r * h x) := by sorry
