-- Generated from ChapterEntropy.lean — solution of BookProof.ChapterEntropy.invertibleProb_le_one
import Mathlib
import Definitions.Def_ChapterEntropy
import Theorems.Thm_BookProof_ChapterEntropy_invertibleProb_eq
open BookProof.ChapterEntropy




open Filter Asymptotics
open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : invertibleProb n ≤ 1 := by

  rw [invertibleProb_eq]
  rcases Nat.eq_zero_or_pos n with h | h
  · subst h; simp
  · rw [div_le_one (by positivity)]
    exact_mod_cast Nat.factorial_le_pow n
