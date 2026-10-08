-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_esa
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

theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_esa (M alpha : ℝ) (halpha : 0 < alpha)
    (S : VielbeinSpectrum ι) (g : ℝ) :
    EssentiallySelfAdjointOn (secN (starobinskyWall M alpha halpha) (S.modes g)).dom
      (secData (starobinskyWall M alpha halpha) (S.modes g)).ext := by sorry
