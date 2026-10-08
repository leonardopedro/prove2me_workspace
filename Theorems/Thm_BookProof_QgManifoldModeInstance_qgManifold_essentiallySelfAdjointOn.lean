-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.qgManifold_essentiallySelfAdjointOn
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterQgTimeStepping
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.FockSecondQuantization
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.QgManifoldModeInstance



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

noncomputable section

variable {ι : Type*}

variable (S : VielbeinSpectrum ι)

theorem BookProof.QgManifoldModeInstance.qgManifold_essentiallySelfAdjointOn (W : WallPot) (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (S.modes g)).dom (secData W (S.modes g)).ext := by sorry
