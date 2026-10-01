-- Generated from ChapterQgContinuumModeInstance.lean — theorem BookProof.QgContinuumModeInstance.starobinsky_qgContinuum_esa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData



open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgContinuumModeInstance.starobinsky_qgContinuum_esa (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgContinuumModes g)).dom
      (secData (starobinskyWall M alpha halpha) (qgContinuumModes g)).ext := by sorry
