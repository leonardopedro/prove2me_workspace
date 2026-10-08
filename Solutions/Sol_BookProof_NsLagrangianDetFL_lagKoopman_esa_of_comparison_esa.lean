-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagKoopman_esa_of_comparison_esa
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lam_nonneg
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_eval_ge
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagFlux_eval_bound
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGen_esa_of_lyapunov
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := lagDim K)) (lagComparison S)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := lagDim K)) (lagKoopmanOp S) :=
  kvnGen_esa_of_lyapunov (lagG_realCoeff S) (lagE_realCoeff S)
      (mul_nonneg (by linarith [S.nu_nonneg]) (Finset.sum_nonneg fun j _ => lam_nonneg S j))
      (fun y => le_trans zero_le_one (lagE_eval_ge S y)) (lagFlux_eval_bound S) hN
