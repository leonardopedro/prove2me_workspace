-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.Jdens_sq
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution : Jdens * Jdens = -1 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Jdens, Matrix.mul_apply, Fin.sum_univ_two]
