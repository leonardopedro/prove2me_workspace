-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.densityMatrix_apply_zero
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
import Theorems.Thm_BookProof_ChapterEulerDensityMatrix_densityMatrix_eq
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : densityMatrix t 0 0 = Real.cos t ^ 2 := by

  rw [densityMatrix_eq]; simp
