-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.visSym_meas
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow.FockLagrangian

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : Measurable S.visSym := measurable_const.mul (Finset.univ.measurable_sum fun i _ => (S.Q_meas i).pow_const 2)
