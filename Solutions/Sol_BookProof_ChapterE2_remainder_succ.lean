-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.remainder_succ
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (N : ℕ) :
    remainder θ (N + 1) = remainder θ N * Real.sin (θ N) ^ 2 := by

  simp [remainder, Finset.prod_range_succ]
