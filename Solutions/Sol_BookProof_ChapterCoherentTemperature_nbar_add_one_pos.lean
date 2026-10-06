-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.nbar_add_one_pos
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) : 0 < nbar + 1 := by
 linarith
