-- Generated from ChapterThermalTemperatureCore.lean — theorem BookProof.ChapterThermalTemperatureCore.half_integer_floor_coherent
import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation
open BookProof.ChapterThermalTemperatureCore


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

theorem BookProof.ChapterThermalTemperatureCore.half_integer_floor_coherent {lam : ℝ} (h : 0 ≤ lam) :
    1 / 2 ≤ ∑' n : ℕ, ((n : ℝ) + 1 / 2) * coherentOccupation lam n := by sorry
