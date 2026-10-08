-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.thermalOccupation_energy
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalProb_summable
import Theorems.Thm_BookProof_ChapterCoherentOccupation_thermalProb_mul_summable
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_mean
import Theorems.Thm_BookProof_ChapterCoherentTemperature_thermalProb_tsum_one
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution {nbar : ℝ} (h : 0 ≤ nbar) :
    ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n = nbar + 1 / 2 := by

  have hsplit : ∀ n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n
      = (n : ℝ) * thermalProb nbar n + (1 / 2) * thermalProb nbar n := fun n => by ring
  rw [tsum_congr hsplit,
    Summable.tsum_add (thermalProb_mul_summable h) ((thermalProb_summable h).mul_left (1 / 2)),
    (thermalProb_summable h).tsum_mul_left, thermalProb_mean h, thermalProb_tsum_one h]
  ring
