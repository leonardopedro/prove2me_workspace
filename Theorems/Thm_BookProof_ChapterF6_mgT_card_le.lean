-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgT_card_le
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6


open scoped BigOperators


variable {α : Type*} [DecidableEq α]


theorem BookProof.ChapterF6.mgT_card_le (k : ℕ) (T : α →₀ ℕ) (s : List α) (hT : T.support.card ≤ k) :
    (mgT k T s).support.card ≤ k := by sorry
