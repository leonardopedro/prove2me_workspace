-- Generated from ChapterTotalVariance.lean — solution of ChapterTotalVariance.between_nonneg
import Mathlib
import Definitions.Def_ChapterTotalVariance
open ChapterTotalVariance




open scoped BigOperators
open Finset

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

set_option maxHeartbeats 1000000 in
theorem solution (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ) (hw : ∀ ω, 0 ≤ w ω) :
    0 ≤ between w X Y := by

  refine Finset.sum_nonneg (fun ω _ => ?_)
  exact mul_nonneg (hw ω) (sq_nonneg _)
