-- Generated from ChapterInverseTransform.lean — solution of BookProof.InverseTransform.seedSet_measure
import Mathlib
import Definitions.Def_ChapterInverseTransform
import Theorems.Thm_BookProof_InverseTransform_cdf_succ_sub
open BookProof.InverseTransform




open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)

variable {n : ℕ} (p : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    volume (seedSet p k) = ENNReal.ofReal (p k) := by

  rw [← cdf_succ_sub p k, seedSet, Real.volume_Ico]
