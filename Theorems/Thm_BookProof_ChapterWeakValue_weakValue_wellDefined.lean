-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_wellDefined
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_wellDefined (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : ip f i ≠ 0) : weakValue i f A * ip f i = ip f (A *ᵥ i) := by sorry
