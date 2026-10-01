-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.qgManifold_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
open BookProof.QgManifoldModeInstance

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

noncomputable section

variable {ι : Type*}

theorem BookProof.QgManifoldModeInstance.qgManifold_essentiallySelfAdjointOn (W : WallPot) (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (S.modes g)).dom (secData W (S.modes g)).ext := by sorry
