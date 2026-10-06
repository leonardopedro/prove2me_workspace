-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.thermalRatio_lt_one
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
import Theorems.Thm_BookProof_ChapterCoherentTemperature_nbar_add_one_pos
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) : thermalRatio nbar < 1 := by

  rw [thermalRatio, div_lt_one (nbar_add_one_pos h)]
  linarith
