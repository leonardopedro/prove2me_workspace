-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgSum_add_single
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (T : α →₀ ℕ) (x : α) :
    mgSum (T + Finsupp.single x 1) = mgSum T + 1 := by

  simp [ mgSum, Finsupp.sum_add_index' ]
