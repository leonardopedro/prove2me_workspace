-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagComparison_quadForm_ge
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_eval_ge
import Theorems.Thm_BookProof_KoopmanLyapunov_lyapunovComparison_quadForm
import Theorems.Thm_BookProof_KoopmanLyapunov_quadForm_mulCoreOp
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
    ‖(x : L2d (lagDim K))‖ ^ 2 ≤ quadForm (lagComparison S) x := by

  rw [lagComparison, lyapunovComparison_quadForm (lagG_realCoeff S)]
  have h1 : ‖(x : L2d (lagDim K))‖ ^ 2 ≤ quadForm (mulCoreOp (lagE S)) x := by
    set p := (coreRepPoly (lagDim K)).equiv.symm x
    rw [norm_core_sq, quadForm_mulCoreOp]
    have := gpair_mul_mono (g := 1) (s := lagE S) (fun y => by
      simpa using lagE_eval_ge S y) p
    simpa using this
  nlinarith [sq_nonneg ‖kvnGenOp (lagG S) x‖]
