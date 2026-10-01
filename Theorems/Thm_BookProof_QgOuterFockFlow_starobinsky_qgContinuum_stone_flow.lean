-- Generated from ChapterQgOuterFockFlow.lean — theorem BookProof.QgOuterFockFlow.starobinsky_qgContinuum_stone_flow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.EsaClosure
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.StoneBridge

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

theorem BookProof.QgOuterFockFlow.starobinsky_qgContinuum_stone_flow (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (U : ℝ → (Sec CMode →L[ℂ] Sec CMode)),
      IsSelfAdjointExtension (secData (starobinskyWall M alpha halpha)
          (qgContinuumModes g)).ext T.op ∧ IsStoneFlow T U := by sorry
