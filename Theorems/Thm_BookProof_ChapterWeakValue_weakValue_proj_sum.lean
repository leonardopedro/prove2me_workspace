-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_proj_sum
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.weakValue_proj_sum (i f : Fin n → ℂ) (h : ip f i ≠ 0) :
    ∑ a, weakValue i f (projMat a) = 1 := by sorry
