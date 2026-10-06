-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.geometricOccupancy_eq_thermalProb
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ r) (h1 : r < 1) (n : ℕ) :
    geometricOccupancy r n = thermalProb (geometricMean r) n := by

  have h1' : (0 : ℝ) < 1 - r := by linarith
  have hratio : thermalRatio (geometricMean r) = r := by
    rw [thermalRatio, geometricMean]
    field_simp
    ring
  rw [thermalProb, hratio, geometricOccupancy, geometricMean]
  congr 1
  field_simp
  ring
