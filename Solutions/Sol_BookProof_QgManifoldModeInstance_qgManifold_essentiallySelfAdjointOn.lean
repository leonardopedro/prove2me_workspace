-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.qgManifold_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
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
theorem solution (W : WallPot) (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (S.modes g)).dom (secData W (S.modes g)).ext := secHam_essentiallySelfAdjointOn W _
