-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_one
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.weakValue_one (i f : Fin n → ℂ) (h : ip f i ≠ 0) :
    weakValue i f (1 : Matrix (Fin n) (Fin n) ℂ) = 1 := by sorry
