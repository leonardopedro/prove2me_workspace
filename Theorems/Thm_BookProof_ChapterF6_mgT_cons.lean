-- Generated from ChapterF6.lean — theorem BookProof.ChapterF6.mgT_cons
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6


open scoped BigOperators


variable {α : Type*} [DecidableEq α]


theorem BookProof.ChapterF6.mgT_cons (k : ℕ) (T : α →₀ ℕ) (x : α) (xs : List α) :
    mgT k T (x :: xs) = mgT k (mgStep k T x) xs := by sorry
