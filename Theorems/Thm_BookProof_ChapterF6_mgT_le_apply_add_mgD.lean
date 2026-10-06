-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgT_le_apply_add_mgD
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]


open scoped BigOperators



theorem BookProof.ChapterF6.mgT_le_apply_add_mgD (k : ℕ) (T : α →₀ ℕ) (s : List α) (y : α) :
    T y + s.count y ≤ (mgT k T s) y + mgD k T s := by sorry
