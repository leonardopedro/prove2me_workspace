-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.qgElimModes_A
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Theorems.Thm_BookProof_QgFourierElim_elimGram_funext
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (g : ℝ) : (qgElimModes g).A = elimGram := elimGram_funext.symm
