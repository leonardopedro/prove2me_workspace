-- Generated from ChapterQgOuterFockFlow.lean — theorem BookProof.QgOuterFockFlow.qgOuterFock_stone_flow
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.StoneBridge
open BookProof.QgOuterFockFlow

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

theorem BookProof.QgOuterFockFlow.qgOuterFock_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (U : ℝ → (Sec ι →L[ℂ] Sec ι)),
      IsSelfAdjointExtension (secData W Q).ext T.op ∧ IsStoneFlow T U := by sorry
