-- Generated from ChapterYangMillsFockFriedrichs.lean — theorem BookProof.YmFockFriedrichs.ymSectorHam_quadForm_nonneg
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YmFockFriedrichs



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.YmFockFriedrichs.ymSectorHam_quadForm_nonneg (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ)
    (x : polyGaussCore (d := n * 99)) : 0 ≤ quadForm (ymSectorHam fabc n) x := by sorry
