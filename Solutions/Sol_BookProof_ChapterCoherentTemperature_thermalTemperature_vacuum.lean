-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.thermalTemperature_vacuum
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution : thermalTemperature 0 = 1 / 2 := by

  rw [thermalTemperature]; ring
