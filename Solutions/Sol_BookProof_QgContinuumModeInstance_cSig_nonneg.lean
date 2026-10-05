-- Generated from ChapterQgContinuumModeInstance.lean — solution of BookProof.QgContinuumModeInstance.cSig_nonneg
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance
open BookProof.QgContinuumModeInstance




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : CMode) : 0 ≤ cSig x := le_trans zero_le_one (one_le_cSig x)
