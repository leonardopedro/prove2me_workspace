-- Generated from ChapterQgContinuumModeInstance.lean — theorem BookProof.QgContinuumModeInstance.qgContinuum_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
open BookProof.QgContinuumModeInstance



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgContinuumModeInstance.qgContinuum_essentiallySelfAdjointOn (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgContinuumModes g)).dom
      (secData W (qgContinuumModes g)).ext := by sorry
