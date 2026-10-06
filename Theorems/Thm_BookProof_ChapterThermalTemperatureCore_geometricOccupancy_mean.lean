-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_mean
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalTemperatureCore

variable {r : ℝ}


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_mean (h0 : 0 ≤ r) (h1 : r < 1) :
    ∑' n : ℕ, (n : ℝ) * geometricOccupancy r n = r / (1 - r) := by sorry
