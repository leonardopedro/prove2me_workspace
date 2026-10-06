-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_tsum_one
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

theorem BookProof.ChapterThermalTemperatureCore.geometricOccupancy_tsum_one (h0 : 0 ≤ r) (h1 : r < 1) :
    ∑' n : ℕ, geometricOccupancy r n = 1 := by sorry
