-- Generated from ChapterInverseTransform.lean — solution of BookProof.InverseTransform.cdf_zero
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform




open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)

variable {n : ℕ} (p : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : cdf p 0 = 0 := by

  simp [cdf]
