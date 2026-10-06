-- Generated from ChapterThermalMaxEntropy.lean — solution of BookProof.ChapterThermalMaxEntropy.thermalEntropy_eq
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
import Theorems.Thm_BookProof_ChapterThermalMaxEntropy_log_thermalProb
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalProb_mul_summable
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalProb_summable
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_mean
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_tsum_one
open BookProof.ChapterThermalMaxEntropy



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 < nbar) :
    thermalEntropy nbar = Real.log (nbar + 1) - nbar * Real.log (thermalRatio nbar) := by

  have h0 : (0 : ℝ) ≤ nbar := le_of_lt h
  have sP := thermalProb_summable h0
  have sN := thermalProb_mul_summable h0
  have hf : ∀ n : ℕ, thermalProb nbar n * Real.log (thermalProb nbar n)
      = (-Real.log (nbar + 1)) * thermalProb nbar n
        + Real.log (thermalRatio nbar) * ((n : ℝ) * thermalProb nbar n) := by
    intro n; rw [log_thermalProb h n]; ring
  rw [thermalEntropy, tsum_congr hf,
    Summable.tsum_add (sP.mul_left _) (sN.mul_left _), sP.tsum_mul_left, sN.tsum_mul_left,
    thermalProb_tsum_one h0, thermalProb_mean h0]
  ring
