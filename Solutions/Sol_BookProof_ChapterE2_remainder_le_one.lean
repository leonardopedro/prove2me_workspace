-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.remainder_le_one
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (N : ℕ) : remainder θ N ≤ 1 := by

  exact Finset.prod_le_one ( fun _ _ => sq_nonneg _ ) fun _ _ => Real.sin_sq_le_one _
