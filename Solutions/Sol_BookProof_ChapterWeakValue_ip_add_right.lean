-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.ip_add_right
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f v w : Fin n → ℂ) : ip f (v + w) = ip f v + ip f w := by

  simp [ip, mul_add, Finset.sum_add_distrib]
