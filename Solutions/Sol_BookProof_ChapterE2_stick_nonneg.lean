-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.stick_nonneg
import Mathlib
import Definitions.Def_ChapterE2
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (n : ℕ) : 0 ≤ stick θ n := by

  apply mul_nonneg
  · exact Finset.prod_nonneg (fun _ _ => sq_nonneg _)
  · exact sq_nonneg _
