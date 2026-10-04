-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.starobinsky_qgElim_esa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.QgFourierElim



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgFourierElim.starobinsky_qgElim_esa (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgElimModes g)).dom
      (secData (starobinskyWall M alpha halpha) (qgElimModes g)).ext := by sorry
