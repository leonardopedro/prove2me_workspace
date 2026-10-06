-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.remainder_nonneg
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (N : ℕ) : 0 ≤ remainder θ N := Finset.prod_nonneg (fun _ _ => sq_nonneg _)
