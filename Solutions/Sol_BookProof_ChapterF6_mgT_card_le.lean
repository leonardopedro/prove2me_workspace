-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgT_card_le
import Mathlib
import Definitions.Def_ChapterF6
import Theorems.Thm_BookProof_ChapterF6_mgT_cons
import Theorems.Thm_BookProof_ChapterF6_mgStep_card_le
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (T : α →₀ ℕ) (s : List α) (hT : T.support.card ≤ k) :
    (mgT k T s).support.card ≤ k := by

  induction s generalizing T with
  | nil => ?_
  | cons x s ih => ?_
  all_goals simp_all only [mgT_nil, mgT_cons]
  exact ih _ ( mgStep_card_le k T x hT )
