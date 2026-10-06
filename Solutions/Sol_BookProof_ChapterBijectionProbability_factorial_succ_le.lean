-- Generated from ChapterBijectionProbability.lean — solution of BookProof.ChapterBijectionProbability.factorial_succ_le
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability



open scoped Nat
open Filter Asymptotics

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : (n + 1)! ≤ (n + 1) ^ n := by

  induction n with
  | zero => simp
  | succ m ih =>
    calc (m + 2)! = (m + 2) * (m + 1)! := by rw [Nat.factorial_succ]
      _ ≤ (m + 2) * (m + 1) ^ m := Nat.mul_le_mul_left _ ih
      _ ≤ (m + 2) * (m + 2) ^ m := Nat.mul_le_mul_left _ (Nat.pow_le_pow_left (by omega) m)
      _ = (m + 2) ^ (m + 1) := by ring
