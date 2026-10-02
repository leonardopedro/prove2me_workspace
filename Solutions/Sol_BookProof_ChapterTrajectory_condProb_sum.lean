-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.condProb_sum
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) (hf : finalProb U V psi f ≠ 0) :
    ∑ a, condProb U V psi f a = 1 := by

  unfold condProb
  rw [← Finset.sum_div]
  exact div_self hf
