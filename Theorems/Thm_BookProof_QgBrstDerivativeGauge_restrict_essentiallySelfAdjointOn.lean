-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.restrict_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
open BookProof.QgBrstDerivativeGauge













open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgBrstDerivativeGauge.restrict_essentiallySelfAdjointOn {ι : Type*} (W : WallPot) (Q : QgModeData ι)
    (s : Set ι) :
    EssentiallySelfAdjointOn (secN W (restrictModes Q s)).dom
      (secData W (restrictModes Q s)).ext := by sorry
