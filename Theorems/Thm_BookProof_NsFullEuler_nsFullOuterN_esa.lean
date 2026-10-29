-- Generated from ChapterNavierStokesFullEulerianFock.lean — theorem BookProof.NsFullEuler.nsFullOuterN_esa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterLeafGaps
import Definitions.Def_ChapterQgOuterFockInteractionFL
open BookProof.HermiteProductCore



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

theorem BookProof.NsFullEuler.nsFullOuterN_esa (nu lam mu gg : ℝ) :
    EssentiallySelfAdjointOn (nsOuterComparison nu lam mu gg).dom
      (nsOuterComparison nu lam mu gg).op := by sorry
