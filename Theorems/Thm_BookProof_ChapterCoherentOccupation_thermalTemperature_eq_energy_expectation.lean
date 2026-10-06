-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.thermalTemperature_eq_energy_expectation
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.thermalTemperature_eq_energy_expectation {nbar : ℝ} (h : 0 ≤ nbar) :
    thermalTemperature nbar = ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n := by sorry
