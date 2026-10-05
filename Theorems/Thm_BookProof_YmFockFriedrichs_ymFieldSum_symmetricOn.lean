-- Generated from ChapterYangMillsFockFriedrichs.lean — theorem BookProof.YmFockFriedrichs.ymFieldSum_symmetricOn
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.YmFockFriedrichs



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.YmFockFriedrichs.ymFieldSum_symmetricOn (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ)
    (s : Fin (n * 24) ⊕ Fin (n * 8)) :
    SymmetricOn (polyGaussCore (d := n * 99))
      ((polyGaussCore (d := n * 99)).subtype.comp (ymFieldSum fabc n s)) := by sorry
