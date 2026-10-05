-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.kinSym_meas
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : Measurable S.kinSym := measurable_const.mul (Finset.univ.measurable_sum fun i _ => (S.P_meas i).pow_const 2)
