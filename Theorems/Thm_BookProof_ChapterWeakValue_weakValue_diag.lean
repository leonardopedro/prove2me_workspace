-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_diag
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_diag (i : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (hi : ip i i = 1) : weakValue i i A = ip i (A *ᵥ i) := by sorry
