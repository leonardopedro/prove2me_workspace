-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.tailSum_last
import Mathlib
import Definitions.Def_ChapterEulerNState
import Theorems.Thm_BookProof_ChapterEulerNState_tailSum_succ
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (p : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    tailSum p n (n - 1) = p (n - 1) := by

  have h : n - 1 < n := by omega
  rw [tailSum_succ p n (n - 1) h]
  have : tailSum p n ((n - 1) + 1) = 0 := by
    rw [tailSum]
    have : (n - 1) + 1 = n := by omega
    rw [this]; simp
  rw [this, add_zero]
