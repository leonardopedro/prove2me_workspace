-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_diag
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (hi : ip i i = 1) : weakValue i i A = ip i (A *ᵥ i) := by

  rw [weakValue, hi, div_one]
