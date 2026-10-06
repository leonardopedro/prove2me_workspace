-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.thermalTemperature_eq_energy_expectation
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalOccupation_energy
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution {nbar : ℝ} (h : 0 ≤ nbar) :
    thermalTemperature nbar = ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n := by

  rw [thermalOccupation_energy h, thermalTemperature]
