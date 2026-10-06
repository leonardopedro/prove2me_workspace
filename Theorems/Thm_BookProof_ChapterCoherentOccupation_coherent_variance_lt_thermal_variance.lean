-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.coherent_variance_lt_thermal_variance
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.coherent_variance_lt_thermal_variance {nbar : ℝ} (h : 0 < nbar) :
    ((∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation nbar n)
        - (∑' n : ℕ, (n : ℝ) * coherentOccupation nbar n) ^ 2)
      < ((∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n)
        - (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) ^ 2) := by sorry
