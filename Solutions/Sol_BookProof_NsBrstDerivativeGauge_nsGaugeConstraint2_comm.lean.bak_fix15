-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsGaugeConstraint2_comm
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_genY2_commute
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) :
    nsGaugeConstraint2 j * nsGaugeConstraint2 k
      = nsGaugeConstraint2 k * nsGaugeConstraint2 j := by

  have h := genY2_genY2_commute j k
  rw [Ring.lie_def, sub_eq_zero] at h
  rw [nsGaugeConstraint2, nsGaugeConstraint2, ← nsBos_mul, ← nsBos_mul, h]
