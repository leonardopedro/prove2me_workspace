-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.geometricOccupancy_tsum_one
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterThermalTemperatureCore_geometricMean_nonneg
import Theorems.Thm_BookProof_ChapterThermalTemperatureCore_geometricOccupancy_eq_thermalProb
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_tsum_one
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ r) (h1 : r < 1) :
    ∑' n : ℕ, geometricOccupancy r n = 1 := by

  rw [tsum_congr (geometricOccupancy_eq_thermalProb h0 h1)]
  exact thermalProb_tsum_one (geometricMean_nonneg h0 h1)
