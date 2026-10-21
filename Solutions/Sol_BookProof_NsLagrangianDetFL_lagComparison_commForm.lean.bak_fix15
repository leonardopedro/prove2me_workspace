-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagComparison_commForm
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_flux
import Theorems.Thm_BookProof_KoopmanLyapunov_commForm_kvnGen_mul
import Theorems.Thm_BookProof_KoopmanLyapunov_lyapunovComparison_commForm
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := lagDim K)) :
    commForm (lagKoopmanOp S) (lagComparison S) x
      = (gpair ((coreRepPoly (lagDim K)).equiv.symm x)
          (rename lagEquiv (lagFlux S) * (coreRepPoly (lagDim K)).equiv.symm x)).re := by

  rw [lagKoopmanOp, lagComparison, lyapunovComparison_commForm (lagG_realCoeff S),
    commForm_kvnGen_mul (lagG_realCoeff S) (lagE_realCoeff S)]
  have h := lagG_flux S
  exact congrArg (fun r => (gpair ((coreRepPoly (lagDim K)).equiv.symm x)
    (r * (coreRepPoly (lagDim K)).equiv.symm x)).re) h
