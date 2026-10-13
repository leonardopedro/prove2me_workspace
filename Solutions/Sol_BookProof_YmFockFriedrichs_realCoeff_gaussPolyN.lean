-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.realCoeff_gaussPolyN
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_sum
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (a : Fin 8) : RealCoeff (gaussPolyN p a) := RealCoeff.sum fun _ _ => realCoeff_X _
