-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.gaugeFixedSubset_esa
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
open BookProof.QgBrstDerivativeGauge



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgBrstDerivativeGauge.gaugeFixedSubset_esa (W : WallPot) (g : ℝ) (s : Set CMode) :
    EssentiallySelfAdjointOn (secN W (restrictModes (qgContinuumModes g) s)).dom
      (secData W (restrictModes (qgContinuumModes g) s)).ext := by sorry
