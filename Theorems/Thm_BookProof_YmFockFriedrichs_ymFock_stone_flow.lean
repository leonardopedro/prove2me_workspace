-- Generated from ChapterYangMillsFockFriedrichs.lean — theorem BookProof.YmFockFriedrichs.ymFock_stone_flow
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.StoneBridge
open BookProof.YangMillsFriedrichs
open BookProof.YmFockFriedrichs



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.YmFockFriedrichs.ymFock_stone_flow (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint ymFockSpace) (U : ℝ → (ymFockSpace →L[ℂ] ymFockSpace)),
      IsStoneFlow T U := by sorry
