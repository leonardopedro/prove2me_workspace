-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.qgElim_esa
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Theorems.Thm_BookProof_QgContinuumModeInstance_qgContinuum_essentiallySelfAdjointOn
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.QgVielbeinScalaronGaugeFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgElimModes g)).dom (secData W (qgElimModes g)).ext := qgContinuum_essentiallySelfAdjointOn W g
