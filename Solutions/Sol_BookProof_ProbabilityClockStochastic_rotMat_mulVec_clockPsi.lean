-- Generated from ChapterProbabilityClockStochastic.lean — solution of BookProof.ProbabilityClockStochastic.rotMat_mulVec_clockPsi
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic




open Matrix
open scoped Norms.Operator

set_option maxHeartbeats 1000000 in
theorem solution (t a : ℝ) :
    (rotMat a).mulVec (clockPsi t) = clockPsi (t + a) := by

  funext i
  fin_cases i <;>
    simp [rotMat, clockPsi, Matrix.mulVec, dotProduct, Fin.sum_univ_two,
      Real.cos_add, Real.sin_add] <;> ring
