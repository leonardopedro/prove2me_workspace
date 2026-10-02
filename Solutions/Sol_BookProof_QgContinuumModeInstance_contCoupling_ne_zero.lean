-- Generated from ChapterQgContinuumModeInstance.lean — solution of BookProof.QgContinuumModeInstance.contCoupling_ne_zero
import Mathlib
import Definitions.Def_ChapterQgContinuumModeInstance




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (g : ℝ) (hg : g ≠ 0) (k : Mom) :
    contCoupling g ((k, 0, 0) : CMode) (k, 0, 0) ≠ 0 := by

  simp only [contCoupling, cTrace]
  norm_num [hg]
