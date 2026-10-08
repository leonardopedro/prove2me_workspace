-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.half_integer_floor
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

theorem BookProof.ChapterThermalTemperatureCore.half_integer_floor {nbar : ℝ} (h : 0 ≤ nbar) :
    1 / 2 ≤ (∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n) ∧
      ((∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n) = 1 / 2 ↔ nbar = 0) := by sorry
