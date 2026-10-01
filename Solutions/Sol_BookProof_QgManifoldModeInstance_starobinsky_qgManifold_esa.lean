-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.starobinsky_qgManifold_esa
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Theorems.Thm_BookProof_QgManifoldModeInstance_qgManifold_essentiallySelfAdjointOn
open BookProof.QgManifoldModeInstance




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha)
    (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN (starobinskyWall M alpha halpha) (S.modes g)).dom
      (secData (starobinskyWall M alpha halpha) (S.modes g)).ext := qgManifold_essentiallySelfAdjointOn (starobinskyWall M alpha halpha) S g
