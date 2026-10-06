-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgStep_apply_le
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]


open scoped BigOperators



theorem BookProof.ChapterF6.mgStep_apply_le (k : ℕ) (T : α →₀ ℕ) (x y : α) :
    (mgStep k T x) y ≤ T y + (if y = x then 1 else 0) := by sorry
