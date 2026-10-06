-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.sum_cos_tail
import Mathlib
import Definitions.Def_ChapterEulerNState
import Theorems.Thm_BookProof_ChapterEulerNState_tailProd_succ
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (m : ℕ) :
    ∑ k ∈ Finset.range m, tailProd θ k * Real.cos (θ k) ^ 2
      = 1 - tailProd θ m := by

  induction m with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, ih, tailProd_succ]
    have : Real.cos (θ m) ^ 2 = 1 - Real.sin (θ m) ^ 2 := by
      have := Real.sin_sq_add_cos_sq (θ m); linarith
    rw [this]; ring
