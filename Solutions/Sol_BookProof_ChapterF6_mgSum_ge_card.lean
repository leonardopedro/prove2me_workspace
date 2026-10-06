-- Generated from ChapterF6.lean — solution of BookProof.ChapterF6.mgSum_ge_card
import Mathlib
import Definitions.Def_ChapterF6
open BookProof.ChapterF6



open scoped BigOperators


variable {α : Type*} [DecidableEq α]

variable {α : Type*} [DecidableEq α]

set_option maxHeartbeats 1000000 in
theorem solution (T : α →₀ ℕ) : T.support.card ≤ mgSum T := by

  exact Finset.card_eq_sum_ones _ ▸ Finset.sum_le_sum fun x hx => Nat.one_le_iff_ne_zero.mpr (
      Finsupp.mem_support_iff.mp hx )
