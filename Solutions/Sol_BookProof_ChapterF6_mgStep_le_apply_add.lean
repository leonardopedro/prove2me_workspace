-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgStep_le_apply_add
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (T : α →₀ ℕ) (x y : α) :
    T y + (if y = x then 1 else 0)
      ≤ (mgStep k T x) y + (if 0 < T x ∨ T.support.card < k then 0 else 1) := by

  unfold mgStep; split_ifs <;> simp_all [ Finsupp.mapRange_apply ] ;
  omega
