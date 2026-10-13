-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.starobinsky_brstGaugeFixed_esa
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Theorems.Thm_BookProof_QgContinuumModeInstance_starobinsky_qgContinuum_esa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgBrstDerivativeGauge




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgContinuumModes g)).dom
      (secData (starobinskyWall M alpha halpha) (qgContinuumModes g)).ext := starobinsky_qgContinuum_esa M alpha halpha g
