-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_one
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_one (i f : Fin n → ℂ) (h : ip f i ≠ 0) :
    weakValue i f (1 : Matrix (Fin n) (Fin n) ℂ) = 1 := by sorry
