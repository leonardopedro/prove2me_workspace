-- Generated from ChapterInverseTransform.lean — solution of BookProof.InverseTransform.cdf_succ_sub
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform




open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)

variable {n : ℕ} (p : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : cdf p (k + 1) - cdf p k = p k := by

  unfold cdf
  rw [Finset.sum_range_succ]
  ring
