-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.half_lt_thermalTemperature
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 < nbar) : 1 / 2 < thermalTemperature nbar := by

  rw [thermalTemperature]; linarith
