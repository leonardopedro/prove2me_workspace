-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.weakValue_wellDefined
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : ip f i ≠ 0) : weakValue i f A * ip f i = ip f (A *ᵥ i) := div_mul_cancel₀ _ h
