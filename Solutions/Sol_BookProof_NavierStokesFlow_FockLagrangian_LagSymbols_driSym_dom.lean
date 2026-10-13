-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.driSym_dom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_const_mul
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_sum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum
open BookProof.NavierStokesFlow.FockLagrangian

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : DominatedOn μ S.scale S.driSym := DominatedOn.sum Finset.univ fun i _ => DominatedOn.const_mul _ (S.Dr_dom i)
