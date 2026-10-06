-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgT_sum_add
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]


open scoped BigOperators



theorem BookProof.ChapterF6.mgT_sum_add (k : ℕ) (T : α →₀ ℕ) (s : List α) (hT : T.support.card ≤ k) :
    mgSum (mgT k T s) + (k + 1) * mgD k T s = mgSum T + s.length := by sorry
