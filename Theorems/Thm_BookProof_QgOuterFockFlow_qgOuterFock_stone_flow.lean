-- Generated from ChapterQgOuterFockFlow.lean — theorem BookProof.QgOuterFockFlow.qgOuterFock_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
open BookProof.QgOuterFockFlow



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
