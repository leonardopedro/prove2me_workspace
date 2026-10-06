-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.misra_gries_bound
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]


open scoped BigOperators



theorem BookProof.ChapterF6.misra_gries_bound (k : ℕ) (hk : 1 ≤ k) (s : List α) (x : α) :
    s.count x - s.length / k ≤ (mg k s) x ∧ (mg k s) x ≤ s.count x := by sorry
