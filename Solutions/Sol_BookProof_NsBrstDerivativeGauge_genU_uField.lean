-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genU_uField
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.NavierStokesGaugeY

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m j : Fin 3) : genU m (uField j) = if m = j then 1 else 0 := by

  simp only [genU_apply, uField, map_add, map_sum, pderiv_mul, pderiv_X, Pi.single_apply,
    NSVar.u.injEq]
  simp [eq_comm]
