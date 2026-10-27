-- Generated from ChapterTotalVariance.lean — solution of ChapterTotalVariance.between_le_variance
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Theorems.Thm_ChapterTotalVariance_total_variance
import Theorems.Thm_ChapterTotalVariance_within_nonneg
open ChapterTotalVariance




open scoped BigOperators
open Finset

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

set_option maxHeartbeats 1000000 in
theorem solution [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    between w X Y ≤ variance w Y := by

  rw [total_variance w X Y hw]
  linarith [within_nonneg w X Y hw]
