-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFockHam_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymSectorHam_quadForm_nonneg
import Theorems.Thm_BookProof_QgOuterFock_dsOp_quadForm_nonneg
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (x : ymFockCore) :
    0 ≤ quadForm (ymFockHam fabc) x := dsOp_quadForm_nonneg _ (fun n u => ymSectorHam_quadForm_nonneg fabc n u) x
