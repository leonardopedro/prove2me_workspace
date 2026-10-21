-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_comm_hamiltonian2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genY2_comm_nsHamAlg2
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) :
    ⁅nsDerivBrstCharge2, nsHamiltonian2 nu⁆ = 0 := glin_comm_bos genY2 (nsHamAlg2 nu) (fun j => genY2_comm_nsHamAlg2 nu j)
