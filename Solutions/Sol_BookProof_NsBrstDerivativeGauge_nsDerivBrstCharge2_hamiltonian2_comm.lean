-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_hamiltonian2_comm
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsDerivBrstCharge2_comm_hamiltonian2
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) :
    nsDerivBrstCharge2 * nsHamiltonian2 nu = nsHamiltonian2 nu * nsDerivBrstCharge2 := by

  have h := nsDerivBrstCharge2_comm_hamiltonian2 nu
  rwa [Ring.lie_def, sub_eq_zero] at h
