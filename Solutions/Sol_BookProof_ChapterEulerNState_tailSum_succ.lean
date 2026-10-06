-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.tailSum_succ
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (p : ℕ → ℝ) (n k : ℕ) (h : k < n) :
    tailSum p n k = p k + tailSum p n (k + 1) := by

  rw [tailSum, tailSum, Finset.sum_eq_sum_Ico_succ_bot h]
