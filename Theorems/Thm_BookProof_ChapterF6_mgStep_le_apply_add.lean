-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgStep_le_apply_add
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6


open scoped BigOperators


variable {α : Type*} [DecidableEq α]


theorem BookProof.ChapterF6.mgStep_le_apply_add (k : ℕ) (T : α →₀ ℕ) (x y : α) :
    T y + (if y = x then 1 else 0)
      ≤ (mgStep k T x) y + (if 0 < T x ∨ T.support.card < k then 0 else 1) := by sorry
