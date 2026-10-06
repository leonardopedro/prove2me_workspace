-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgT_cons
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (T : α →₀ ℕ) (x : α) (xs : List α) :
    mgT k T (x :: xs) = mgT k (mgStep k T x) xs := by

  simp [mgT, List.foldl_cons]
