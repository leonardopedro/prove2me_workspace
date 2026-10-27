-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.geometricOccupancy_variance
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterThermalTemperatureCore_geometricMean_nonneg
import Theorems.Thm_BookProof_ChapterThermalTemperatureCore_geometricOccupancy_eq_thermalProb
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_variance
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ r) (h1 : r < 1) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * geometricOccupancy r n)
      - (∑' n : ℕ, (n : ℝ) * geometricOccupancy r n) ^ 2 = r / (1 - r) ^ 2 := by

  have h1' : (0 : ℝ) < 1 - r := by linarith
  have hc2 : ∀ n : ℕ, (n : ℝ) ^ 2 * geometricOccupancy r n
      = (n : ℝ) ^ 2 * thermalProb (geometricMean r) n := fun n => by
    rw [geometricOccupancy_eq_thermalProb h0 h1]
  have hc1 : ∀ n : ℕ, (n : ℝ) * geometricOccupancy r n
      = (n : ℝ) * thermalProb (geometricMean r) n := fun n => by
    rw [geometricOccupancy_eq_thermalProb h0 h1]
  rw [tsum_congr hc2, tsum_congr hc1,
    thermalProb_variance (geometricMean_nonneg h0 h1), geometricMean]
  field_simp
  ring
