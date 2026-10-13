-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.hFull_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.NavierStokesFlow.FockLagrangian

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : IsSymmetricDom S.data.hFull := S.data.hFull_isSymmetricDom
