-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymSectorHam_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymPiN_symmetricOn
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFieldN_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ)
    (x : polyGaussCore (d := n * 99)) : 0 ≤ quadForm (ymSectorHam fabc n) x := weylOpDom_quadForm_nonneg (ymPiN_symmetricOn n) (ymFieldN_symmetricOn fabc n) x
