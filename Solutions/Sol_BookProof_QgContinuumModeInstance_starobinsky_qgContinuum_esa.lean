-- Generated from ChapterQgContinuumModeInstance.lean — solution of BookProof.QgContinuumModeInstance.starobinsky_qgContinuum_esa
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
import Theorems.Thm_BookProof_QgContinuumModeInstance_qgContinuum_essentiallySelfAdjointOn




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgContinuumModes g)).dom
      (secData (starobinskyWall M alpha halpha) (qgContinuumModes g)).ext := qgContinuum_essentiallySelfAdjointOn (starobinskyWall M alpha halpha) g
