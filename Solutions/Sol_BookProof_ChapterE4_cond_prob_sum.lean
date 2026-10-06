-- Generated from ChapterE4.lean — solution of BookProof.ChapterE4.cond_prob_sum
import Mathlib
import Definitions.Def_ChapterE4
open BookProof.ChapterE4



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (s : ℕ) :
    Real.cos (θ s) ^ 2 + Real.sin (θ s) ^ 2 = 1 := by

  exact Real.cos_sq_add_sin_sq _
