-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.starobinsky_qgManifold_esa
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Theorems.Thm_BookProof_QgManifoldModeInstance_qgManifold_essentiallySelfAdjointOn
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
theorem solution (M alpha : ℝ) (halpha : 0 < alpha)
    (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN (starobinskyWall M alpha halpha) (S.modes g)).dom
      (secData (starobinskyWall M alpha halpha) (S.modes g)).ext := qgManifold_essentiallySelfAdjointOn (starobinskyWall M alpha halpha) S g
