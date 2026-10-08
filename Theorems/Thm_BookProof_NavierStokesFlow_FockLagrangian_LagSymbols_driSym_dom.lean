-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.driSym_dom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian


open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {μ : Measure X} (S : LagSymbols X μ)

theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.driSym_dom : DominatedOn μ S.scale S.driSym := by sorry
