-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgT_apply_le
import Mathlib
import Definitions.Def_ChapterF6
import Theorems.Thm_BookProof_ChapterF6_mgStep_apply_le
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (T : α →₀ ℕ) (s : List α) (y : α) :
    (mgT k T s) y ≤ T y + s.count y := by

  induction s using List.reverseRecOn generalizing T y with
  | nil => ?_
  | append_singleton s x ih => ?_
  · simp [ mgT ];
  · simp_all only [mgT, List.count, List.foldl_append, List.foldl_cons, List.foldl_nil,
      List.countP_append, List.countP_singleton, beq_iff_eq];
    refine le_trans ( mgStep_apply_le k _ _ _ ) ?_;
    grind
