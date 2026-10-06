-- Generated from ChapterE4.lean — solution of BookProof.ChapterE4.wave_self_succ
import Mathlib
import Definitions.Def_ChapterE4
import Theorems.Thm_BookProof_ChapterE4_wave_succ
import Theorems.Thm_BookProof_ChapterE4_wave_eq_zero_of_lt
open BookProof.ChapterE4



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (s d : ℕ) :
    wave θ s (d + 1) s = Real.cos (θ s) := by

  -- Unfold one stick-break; the tail contributes nothing at index `s`.
  rw [wave_succ]
  simp only [basisVec, Pi.single_eq_same, mul_one, add_eq_left, mul_eq_zero];
  exact Or.inr ( wave_eq_zero_of_lt _ _ _ _ ( Nat.lt_succ_self _ ) )
