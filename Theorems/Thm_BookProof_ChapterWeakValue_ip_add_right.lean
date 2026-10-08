-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.ip_add_right
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.ip_add_right (f v w : Fin n → ℂ) : ip f (v + w) = ip f v + ip f w := by sorry
