-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagComparison_relBound
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagG_realCoeff
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagE_eval_ge
import Theorems.Thm_BookProof_KoopmanLyapunov_lyapunovComparison_relBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet
open BookProof.HermiteProductCore

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (x : polyGaussCore (d := lagDim K)) :
    ‖lagKoopmanOp S x‖ ≤ ‖lagComparison S x‖ + ‖(x : L2d (lagDim K))‖ :=
  lyapunovComparison_relBound (lagG_realCoeff S)
      (fun y => le_trans zero_le_one (lagE_eval_ge S y)) x
