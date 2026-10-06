-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.ip_smul_right
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (f v : Fin n → ℂ) : ip f (c • v) = c * ip f v := by

  simp only [ip, Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun _ _ => by ring
