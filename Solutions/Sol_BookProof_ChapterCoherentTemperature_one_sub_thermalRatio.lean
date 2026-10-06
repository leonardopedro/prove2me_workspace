-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.one_sub_thermalRatio
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) : 1 - thermalRatio nbar = 1 / (nbar + 1) := by

  rw [thermalRatio]
  field_simp
  ring
