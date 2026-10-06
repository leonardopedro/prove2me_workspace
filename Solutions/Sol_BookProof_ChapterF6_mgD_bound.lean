-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgD_bound
import Mathlib
import Definitions.Def_ChapterF6
import Theorems.Thm_BookProof_ChapterF6_mgT_sum_add
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (s : List α) : k * mgD k 0 s ≤ s.length := by

  have h_dec : (k + 1) * mgD k 0 s ≤ s.length := by
    have := mgT_sum_add k 0 s; simp_all only [Finsupp.support_zero, Finset.card_empty, zero_le,
        mgSum, Finsupp.sum_zero_index, zero_add, forall_const, ge_iff_le] ;
    exact this ▸ Nat.le_add_left _ _;
  grind
