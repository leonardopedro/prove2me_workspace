-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.restrict_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
open BookProof.QgBrstDerivativeGauge














open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (W : WallPot) (Q : QgModeData ι)
    (s : Set ι) :
    EssentiallySelfAdjointOn (secN W (restrictModes Q s)).dom
      (secData W (restrictModes Q s)).ext := secHam_essentiallySelfAdjointOn W _
