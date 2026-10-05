-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.starobinsky_qgElim_esa
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Theorems.Thm_BookProof_QgContinuumModeInstance_starobinsky_qgContinuum_esa
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgElimModes g)).dom
      (secData (starobinskyWall M alpha halpha) (qgElimModes g)).ext := starobinsky_qgContinuum_esa M alpha halpha g
