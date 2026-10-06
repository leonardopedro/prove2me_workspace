-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.thermalTemperature_eq_mean_add_half
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_mean
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) :
    thermalTemperature nbar = (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) + 1 / 2 := by

  rw [thermalTemperature, thermalProb_mean h]
