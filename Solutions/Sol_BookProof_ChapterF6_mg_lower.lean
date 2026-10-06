-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mg_lower
import Mathlib
import Definitions.Def_ChapterF6
import Theorems.Thm_BookProof_ChapterF6_mgT_le_apply_add_mgD
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (s : List α) (y : α) :
    s.count y ≤ (mg k s) y + mgD k 0 s := by

  have := mgT_le_apply_add_mgD k 0 s y
  simpa [mg] using this
