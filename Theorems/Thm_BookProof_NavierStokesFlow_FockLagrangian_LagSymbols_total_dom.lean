-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.total_dom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian


open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {μ : Measure X} (S : LagSymbols X μ)

theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.total_dom : DominatedOn μ S.scale S.total := by sorry
