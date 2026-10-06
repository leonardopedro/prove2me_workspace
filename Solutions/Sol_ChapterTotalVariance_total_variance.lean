-- Generated from ChapterTotalVariance.lean — solution of ChapterTotalVariance.total_variance
import Mathlib
import Definitions.Def_ChapterTotalVariance
import Theorems.Thm_ChapterTotalVariance_crossTerm_zero
open ChapterTotalVariance




open scoped BigOperators
open Finset

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

variable {Ω κ : Type*} [Fintype Ω] [DecidableEq κ]

set_option maxHeartbeats 1000000 in
theorem solution [Finite κ] (w : Ω → ℝ) (X : Ω → κ) (Y : Ω → ℝ)
    (hw : ∀ ω, 0 ≤ w ω) :
    variance w Y = within w X Y + between w X Y := by

  -- Pythagorean expansion: `(Y - μ)² = (Y - c)² + 2·(Y - c)·(c - μ) + (c - μ)²`
  -- where `c = condMean (X ω)` and `μ = mean`.  Sum termwise; the middle (cross)
  -- term is `2 * crossTerm_zero = 0`.
  have hcross := crossTerm_zero w X Y hw
  simp only [variance, within, between]
  rw [← sub_eq_zero]
  have expand : (∑ ω, w ω * (Y ω - mean w Y) ^ 2)
      - ((∑ ω, w ω * (Y ω - condMean w X Y (X ω)) ^ 2)
         + ∑ ω, w ω * (condMean w X Y (X ω) - mean w Y) ^ 2)
      = 2 * (∑ ω, w ω * (Y ω - condMean w X Y (X ω)) * (condMean w X Y (X ω) - mean w Y)) := by
    rw [← Finset.sum_add_distrib, Finset.mul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl (fun ω _ => ?_)
    ring
  rw [expand, hcross, mul_zero]
