-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.gaugeFixedSubset_esa
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Theorems.Thm_BookProof_QgBrstDerivativeGauge_restrict_essentiallySelfAdjointOn
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
theorem solution (W : WallPot) (g : ℝ) (s : Set CMode) :
    EssentiallySelfAdjointOn (secN W (restrictModes (qgContinuumModes g) s)).dom
      (secData W (restrictModes (qgContinuumModes g) s)).ext := restrict_essentiallySelfAdjointOn W _ s
