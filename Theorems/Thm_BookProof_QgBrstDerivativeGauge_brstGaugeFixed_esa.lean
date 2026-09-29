-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.brstGaugeFixed_esa
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
open BookProof.QgBrstDerivativeGauge













open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgBrstDerivativeGauge.brstGaugeFixed_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgContinuumModes g)).dom
      (secData W (qgContinuumModes g)).ext := by sorry
