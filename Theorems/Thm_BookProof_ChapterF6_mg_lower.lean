-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mg_lower
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6


open scoped BigOperators


variable {α : Type*} [DecidableEq α]


theorem BookProof.ChapterF6.mg_lower (k : ℕ) (s : List α) (y : α) :
    s.count y ≤ (mg k s) y + mgD k 0 s := by sorry
