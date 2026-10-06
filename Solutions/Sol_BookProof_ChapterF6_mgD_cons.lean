-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgD_cons
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (T : α →₀ ℕ) (x : α) (xs : List α) :
    mgD k T (x :: xs) =
      (if 0 < T x ∨ T.support.card < k then 0 else 1) + mgD k (mgStep k T x) xs := rfl
