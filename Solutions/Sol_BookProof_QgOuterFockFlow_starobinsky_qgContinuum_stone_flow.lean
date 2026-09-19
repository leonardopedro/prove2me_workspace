-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.starobinsky_qgContinuum_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_qgOuterFock_stone_flow
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (U : ℝ → (Sec CMode →L[ℂ] Sec CMode)),
      IsSelfAdjointExtension (secData (starobinskyWall M alpha halpha)
          (qgContinuumModes g)).ext T.op ∧ IsStoneFlow T U := qgOuterFock_stone_flow (starobinskyWall M alpha halpha) (qgContinuumModes g)
