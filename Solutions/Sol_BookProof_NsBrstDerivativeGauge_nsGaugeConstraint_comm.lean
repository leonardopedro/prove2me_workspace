-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsGaugeConstraint_comm
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_genY_commute
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
theorem solution (j k : Fin 3) :
    nsGaugeConstraint j * nsGaugeConstraint k = nsGaugeConstraint k * nsGaugeConstraint j := by

  have h := genY_genY_commute j k
  rw [Ring.lie_def, sub_eq_zero] at h
  rw [nsGaugeConstraint, nsGaugeConstraint, ← nsBos_mul, ← nsBos_mul, h]
