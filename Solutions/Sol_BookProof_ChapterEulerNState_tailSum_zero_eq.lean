-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.tailSum_zero_eq
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (p : ℕ → ℝ) (n : ℕ) :
    tailSum p n 0 = ∑ j ∈ Finset.range n, p j := by

  rw [tailSum, Finset.range_eq_Ico]
