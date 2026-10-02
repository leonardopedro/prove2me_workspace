-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.gaugeFixedSubset_esa
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Theorems.Thm_BookProof_QgBrstDerivativeGauge_restrict_essentiallySelfAdjointOn




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) (s : Set CMode) :
    EssentiallySelfAdjointOn (secN W (restrictModes (qgContinuumModes g) s)).dom
      (secData W (restrictModes (qgContinuumModes g) s)).ext := restrict_essentiallySelfAdjointOn W _ s
