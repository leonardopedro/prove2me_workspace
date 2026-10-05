-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFieldN_symmetricOn
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFieldSum_symmetricOn
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ)
    (m : Fin (n * 24 + n * 8)) :
    SymmetricOn (polyGaussCore (d := n * 99))
      ((polyGaussCore (d := n * 99)).subtype.comp (ymFieldN fabc n m)) := ymFieldSum_symmetricOn fabc n (finSumFinEquiv.symm m)
