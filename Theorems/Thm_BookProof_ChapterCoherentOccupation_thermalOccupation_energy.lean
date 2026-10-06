-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.thermalOccupation_energy
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.thermalOccupation_energy {nbar : ℝ} (h : 0 ≤ nbar) :
    ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n = nbar + 1 / 2 := by sorry
