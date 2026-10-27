-- Generated from ChapterThermalMaxEntropy.lean — solution of BookProof.ChapterThermalMaxEntropy.gibbs_pointwise
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
import Theorems.Thm_BookProof_ChapterThermalMaxEntropy_thermalProb_pos
open BookProof.ChapterThermalMaxEntropy



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}

variable {nbar : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h : 0 < nbar) {p : ℝ} (hp : 0 ≤ p) (n : ℕ) :
    p * Real.log (thermalProb nbar n) - p * Real.log p ≤ thermalProb nbar n - p := by

  rcases eq_or_lt_of_le hp with hp0 | hp0
  · simp [← hp0, (thermalProb_pos h n).le]
  · have hq := thermalProb_pos h n
    have hlog : Real.log (thermalProb nbar n / p) ≤ thermalProb nbar n / p - 1 :=
      Real.log_le_sub_one_of_pos (div_pos hq hp0)
    have hsplit : Real.log (thermalProb nbar n / p)
        = Real.log (thermalProb nbar n) - Real.log p := Real.log_div (ne_of_gt hq) (ne_of_gt hp0)
    have hmul := mul_le_mul_of_nonneg_left hlog hp
    rw [hsplit] at hmul
    have hfield : p * (thermalProb nbar n / p - 1) = thermalProb nbar n - p := by field_simp
    nlinarith [hmul]
