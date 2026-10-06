-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_diag_isReal
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_diag_isReal (i : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (hA : Aᴴ = A) (hi : ip i i = 1) :
    starRingEnd ℂ (weakValue i i A) = weakValue i i A := by sorry
