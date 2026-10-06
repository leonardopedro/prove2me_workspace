-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_unique
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : ip f i ≠ 0) (w : ℂ) (hw : w * ip f i = ip f (A *ᵥ i)) :
    w = weakValue i f A := by

  rw [weakValue, eq_div_iff h, hw]
