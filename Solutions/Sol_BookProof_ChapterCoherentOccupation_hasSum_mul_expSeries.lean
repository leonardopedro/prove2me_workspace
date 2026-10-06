-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.hasSum_mul_expSeries
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_hasSum_expSeries
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * (lam ^ n / (n ! : ℝ))) (lam * Real.exp lam) := by

  have key : HasSum (fun n : ℕ => ((n + 1 : ℕ) : ℝ) * (lam ^ (n + 1) / (((n + 1)! : ℕ) : ℝ)))
      (lam * Real.exp lam) := by
    refine ((hasSum_expSeries lam).mul_left lam).congr_fun ?_
    intro n
    rw [Nat.factorial_succ]
    push_cast
    field_simp
    ring
  simpa using
    (hasSum_nat_add_iff (f := fun n : ℕ => (n : ℝ) * (lam ^ n / (n ! : ℝ))) 1).mp key
