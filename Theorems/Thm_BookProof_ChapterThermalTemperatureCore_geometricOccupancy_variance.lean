-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_variance
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalTemperatureCore


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_variance (h0 : 0 ≤ r) (h1 : r < 1) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * geometricOccupancy r n)
      - (∑' n : ℕ, (n : ℝ) * geometricOccupancy r n) ^ 2 = r / (1 - r) ^ 2 := by sorry
