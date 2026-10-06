-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.tailProd_succ
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (m : ℕ) :
    tailProd θ (m + 1) = tailProd θ m * Real.sin (θ m) ^ 2 := by

  simp [tailProd, Finset.prod_range_succ]
