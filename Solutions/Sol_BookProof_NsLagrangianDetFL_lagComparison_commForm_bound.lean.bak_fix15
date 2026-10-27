-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagComparison_commForm_bound
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lam_nonneg
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagFlux_eval_bound
import Theorems.Thm_BookProof_KoopmanLyapunov_commForm_kvnGen_mul_bound
import Theorems.Thm_BookProof_KoopmanLyapunov_lyapunovComparison_commForm
import Theorems.Thm_BookProof_KoopmanLyapunov_lyapunovComparison_quadForm
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
    |commForm (lagKoopmanOp S) (lagComparison S) x|
      ≤ (2 * S.nu * ∑ j, lam S j) * quadForm (lagComparison S) x := by

  rw [lagKoopmanOp, lagComparison, lyapunovComparison_commForm (lagG_realCoeff S)]
  refine le_trans (commForm_kvnGen_mul_bound (lagG_realCoeff S) (lagE_realCoeff S)
    (lagFlux_eval_bound S) x) ?_
  have hc : 0 ≤ 2 * S.nu * ∑ j, lam S j :=
    mul_nonneg (by linarith [S.nu_nonneg]) (Finset.sum_nonneg fun j _ => lam_nonneg S j)
  refine mul_le_mul_of_nonneg_left ?_ hc
  rw [lyapunovComparison_quadForm (lagG_realCoeff S)]
  nlinarith [sq_nonneg ‖kvnGenOp (lagG S) x‖]
