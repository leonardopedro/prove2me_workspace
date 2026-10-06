-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.sum_stick_add_remainder
import Mathlib
import Definitions.Def_ChapterE2
import Theorems.Thm_BookProof_ChapterE2_remainder_succ
import Theorems.Thm_BookProof_ChapterE2_stick_eq
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ range N, stick θ n) + remainder θ N = 1 := by

  induction N with
  | zero => ?_
  | succ N ih => ?_
  · norm_num [ remainder ];
  · simp_all only [sum_range_succ, remainder_succ];
    rw [ ← ih, stick_eq ] ; rw [ Real.sin_sq ] ; ring
