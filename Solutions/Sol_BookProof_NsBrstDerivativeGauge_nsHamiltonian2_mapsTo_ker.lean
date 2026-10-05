-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsHamiltonian2_mapsTo_ker
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsDerivBrstCharge2_hamiltonian2_comm
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) {v : NSGraded} (hv : nsDerivBrstCharge2 v = 0) :
    nsDerivBrstCharge2 (nsHamiltonian2 nu v) = 0 := by

  have h := congrArg (fun L : Module.End ℂ NSGraded => L v)
    (nsDerivBrstCharge2_hamiltonian2_comm nu)
  simpa [Module.End.mul_apply, hv] using h
