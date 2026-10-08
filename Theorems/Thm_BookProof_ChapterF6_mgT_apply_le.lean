-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgT_apply_le
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6


open scoped BigOperators


variable {α : Type*} [DecidableEq α]


theorem BookProof.ChapterF6.mgT_apply_le (k : ℕ) (T : α →₀ ℕ) (s : List α) (y : α) :
    (mgT k T s) y ≤ T y + s.count y := by sorry
