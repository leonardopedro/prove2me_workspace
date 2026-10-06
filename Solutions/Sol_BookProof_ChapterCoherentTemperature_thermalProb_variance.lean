-- Generated from ChapterCoherentTemperature.lean — solution of BookProof.ChapterCoherentTemperature.thermalProb_variance
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_mean
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_second_moment
open BookProof.ChapterCoherentTemperature



noncomputable section




variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 ≤ nbar) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n)
      - (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) ^ 2 = nbar ^ 2 + nbar := by

  rw [thermalProb_second_moment h, thermalProb_mean h]
  ring
