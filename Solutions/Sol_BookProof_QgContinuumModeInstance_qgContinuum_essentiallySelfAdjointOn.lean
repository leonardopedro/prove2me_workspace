-- Generated from ChapterQgContinuumModeInstance.lean — solution of BookProof.QgContinuumModeInstance.qgContinuum_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
open BookProof.QgContinuumModeInstance




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgContinuumModes g)).dom
      (secData W (qgContinuumModes g)).ext := secHam_essentiallySelfAdjointOn W _
