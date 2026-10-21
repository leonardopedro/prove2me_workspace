-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.geometricOccupancy_mean
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterThermalTemperatureCore_geometricMean_nonneg
import Theorems.Thm_BookProof_ChapterThermalTemperatureCore_geometricOccupancy_eq_thermalProb
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_mean
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ r) (h1 : r < 1) :
    ∑' n : ℕ, (n : ℝ) * geometricOccupancy r n = r / (1 - r) := by

  have hcongr : ∀ n : ℕ, (n : ℝ) * geometricOccupancy r n
      = (n : ℝ) * thermalProb (geometricMean r) n := fun n => by
    rw [geometricOccupancy_eq_thermalProb h0 h1]
  rw [tsum_congr hcongr, thermalProb_mean (geometricMean_nonneg h0 h1), geometricMean]
