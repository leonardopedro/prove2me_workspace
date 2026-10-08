-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.thermal_temperature_eq_mean_half
import Definitions.Def_ChapterCoherentOccupation
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Definitions.Def_ChapterBoseEinstein
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterBoseEinstein
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalTemperatureCore


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

theorem BookProof.ChapterThermalTemperatureCore.thermal_temperature_eq_mean_half {x : ℝ} (hx : 0 < x) :
    Real.cosh (x / 2) / (2 * Real.sinh (x / 2))
      = (∑' n : ℕ, (n : ℝ) * thermalProb (boseEinstein x) n) + 1 / 2 := by sorry
