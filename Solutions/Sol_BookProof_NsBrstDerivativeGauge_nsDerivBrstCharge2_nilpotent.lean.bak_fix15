-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_nilpotent
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGradedGhostCar
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsGaugeConstraint2_comm
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_brst_abelian_nilpotent
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : nsDerivBrstCharge2 * nsDerivBrstCharge2 = 0 :=
  brst_abelian_nilpotent nsGradedGhostCar
      (fun _ _ => nsBos_nsGh_comm _ _) (fun _ _ => nsBos_nsGh_comm _ _)
      nsGaugeConstraint2_comm
