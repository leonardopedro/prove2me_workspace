-- Generated from ChapterProbabilityClockStochastic.lean — solution of BookProof.ProbabilityClockStochastic.rotMat_isUnit
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
import Theorems.Thm_BookProof_ProbabilityClockStochastic_rotMat_det
open BookProof.ProbabilityClockStochastic




open Matrix
open scoped Norms.Operator

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) : IsUnit (rotMat a) := by

  rw [Matrix.isUnit_iff_isUnit_det, rotMat_det]; exact isUnit_one
