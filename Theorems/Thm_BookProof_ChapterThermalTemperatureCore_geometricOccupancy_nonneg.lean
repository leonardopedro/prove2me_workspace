-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_nonneg
import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
open BookProof.ChapterThermalTemperatureCore

variable {r : ℝ}


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_nonneg (h0 : 0 ≤ r) (h1 : r < 1) (n : ℕ) :
    0 ≤ geometricOccupancy r n := by sorry
