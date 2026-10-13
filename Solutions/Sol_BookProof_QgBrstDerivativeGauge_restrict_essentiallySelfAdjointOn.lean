-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.restrict_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
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
theorem solution {ι : Type*} (W : WallPot) (Q : QgModeData ι)
    (s : Set ι) :
    EssentiallySelfAdjointOn (secN W (restrictModes Q s)).dom
      (secData W (restrictModes Q s)).ext := secHam_essentiallySelfAdjointOn W _
