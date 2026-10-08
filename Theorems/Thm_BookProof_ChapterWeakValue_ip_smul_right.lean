-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.ip_smul_right
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.ip_smul_right (c : ℂ) (f v : Fin n → ℂ) : ip f (c • v) = c * ip f v := by sorry
