-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_energy
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_hasSum_one
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_hasSum_mean
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    ∑' n : ℕ, ((n : ℝ) + 1 / 2) * coherentOccupation lam n = lam + 1 / 2 := by

  have h := (coherentOccupation_hasSum_mean lam).add
    ((coherentOccupation_hasSum_one lam).mul_left (1 / 2))
  rw [mul_one] at h
  exact (h.congr_fun fun n => by ring).tsum_eq
