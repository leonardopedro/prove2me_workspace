-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.half_integer_floor
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalOccupation_energy
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {nbar : ℝ} (h : 0 ≤ nbar) :
    1 / 2 ≤ (∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n) ∧
      ((∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n) = 1 / 2 ↔ nbar = 0) := by

  rw [thermalOccupation_energy h]
  constructor
  · linarith
  · constructor
    · intro hEq; linarith
    · intro hEq; rw [hEq]; ring
