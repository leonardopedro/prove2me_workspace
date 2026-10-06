-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_variance
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_mean
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_second_moment
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation lam n)
      - (∑' n : ℕ, (n : ℝ) * coherentOccupation lam n) ^ 2 = lam := by

  rw [coherentOccupation_second_moment, coherentOccupation_mean]
  ring
