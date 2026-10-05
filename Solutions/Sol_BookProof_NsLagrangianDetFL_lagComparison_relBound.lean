-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagComparison_relBound
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_eval_ge
import Theorems.Thm_BookProof_KoopmanLyapunov_lyapunovComparison_relBound
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := lagDim K)) :
    ‖lagKoopmanOp S x‖ ≤ ‖lagComparison S x‖ + ‖(x : L2d (lagDim K))‖ :=
  lyapunovComparison_relBound (lagG_realCoeff S)
      (fun y => le_trans zero_le_one (lagE_eval_ge S y)) x
