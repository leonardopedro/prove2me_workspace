-- Generated from ChapterProbabilityClockStochastic.lean — solution of BookProof.ProbabilityClockStochastic.clockPsi_eq_exp
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
import Theorems.Thm_BookProof_ProbabilityClockStochastic_rotMat_eq_exp
open BookProof.ProbabilityClockStochastic




open Matrix
open scoped Norms.Operator

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    (NormedSpace.exp (t • Jgen)).mulVec ![1, 0] = clockPsi t := by

  rw [rotMat_eq_exp]
  funext i
  fin_cases i <;>
    simp [rotMat, clockPsi, Matrix.mulVec, dotProduct, Fin.sum_univ_two]
