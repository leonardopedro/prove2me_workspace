-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.coherentOccupation_energy
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.coherentOccupation_energy (lam : ℝ) :
    ∑' n : ℕ, ((n : ℝ) + 1 / 2) * coherentOccupation lam n = lam + 1 / 2 := by sorry
