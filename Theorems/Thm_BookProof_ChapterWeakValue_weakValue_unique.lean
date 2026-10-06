-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_unique
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_unique (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : ip f i ≠ 0) (w : ℂ) (hw : w * ip f i = ip f (A *ᵥ i)) :
    w = weakValue i f A := by sorry
