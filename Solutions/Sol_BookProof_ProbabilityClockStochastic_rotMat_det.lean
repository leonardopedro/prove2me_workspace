-- Generated from ChapterProbabilityClockStochastic.lean — solution of BookProof.ProbabilityClockStochastic.rotMat_det
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic




open Matrix
open scoped Norms.Operator

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) : (rotMat a).det = 1 := by

  simp only [rotMat, Matrix.det_fin_two_of]
  nlinarith [Real.cos_sq_add_sin_sq a]
