-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgStep_card_le
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]


open scoped BigOperators



theorem BookProof.ChapterF6.mgStep_card_le (k : ℕ) (T : α →₀ ℕ) (x : α) (hT : T.support.card ≤ k) :
    (mgStep k T x).support.card ≤ k := by sorry
