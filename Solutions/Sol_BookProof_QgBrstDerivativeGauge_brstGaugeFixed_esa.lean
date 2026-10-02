-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.brstGaugeFixed_esa
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Theorems.Thm_BookProof_QgContinuumModeInstance_qgContinuum_essentiallySelfAdjointOn




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgContinuumModes g)).dom
      (secData W (qgContinuumModes g)).ext := qgContinuum_essentiallySelfAdjointOn W g
