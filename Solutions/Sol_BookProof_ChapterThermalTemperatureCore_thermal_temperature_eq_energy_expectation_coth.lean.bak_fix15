-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.thermal_temperature_eq_energy_expectation_coth
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterBoseEinstein_boseEinstein_pos
import Theorems.Thm_BookProof_ChapterBoseEinstein_thermalTemperature_boseEinstein_eq_coth
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalOccupation_energy
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : 0 < x) :
    Real.cosh (x / 2) / (2 * Real.sinh (x / 2))
      = ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb (boseEinstein x) n := by

  rw [thermalOccupation_energy (le_of_lt (boseEinstein_pos hx)),
    ← thermalTemperature_boseEinstein_eq_coth hx, thermalTemperature]
