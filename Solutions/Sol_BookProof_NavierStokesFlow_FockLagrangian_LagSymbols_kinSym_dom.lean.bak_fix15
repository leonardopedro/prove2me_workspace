-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.kinSym_dom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_const_mul
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_sq_dom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : DominatedOn μ S.scale S.kinSym := DominatedOn.const_mul _ (DominatedOn.sum Finset.univ fun i _ => S.sq_dom i)
