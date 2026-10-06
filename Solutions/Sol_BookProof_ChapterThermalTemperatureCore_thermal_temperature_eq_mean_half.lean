-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.thermal_temperature_eq_mean_half
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterBoseEinstein_boseEinstein_mean
import Theorems.Thm_BookProof_ChapterBoseEinstein_thermalTemperature_boseEinstein_eq_coth
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : 0 < x) :
    Real.cosh (x / 2) / (2 * Real.sinh (x / 2))
      = (∑' n : ℕ, (n : ℝ) * thermalProb (boseEinstein x) n) + 1 / 2 := by

  rw [← thermalTemperature_boseEinstein_eq_coth hx, boseEinstein_mean hx, thermalTemperature]
