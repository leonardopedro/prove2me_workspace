-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.half_integer_floor_coherent
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_energy
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {lam : ℝ} (h : 0 ≤ lam) :
    1 / 2 ≤ ∑' n : ℕ, ((n : ℝ) + 1 / 2) * coherentOccupation lam n := by

  rw [coherentOccupation_energy]
  linarith
