-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherent_variance_lt_thermal_variance
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_variance
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_variance
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution {nbar : ℝ} (h : 0 < nbar) :
    ((∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation nbar n)
        - (∑' n : ℕ, (n : ℝ) * coherentOccupation nbar n) ^ 2)
      < ((∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n)
        - (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) ^ 2) := by

  rw [coherentOccupation_variance, thermalProb_variance h.le]
  nlinarith
