-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.qgManifold_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgManifoldModeInstance




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping
open BookProof.FockSecondQuantization
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (S.modes g)).dom (secData W (S.modes g)).ext := secHam_essentiallySelfAdjointOn W _
