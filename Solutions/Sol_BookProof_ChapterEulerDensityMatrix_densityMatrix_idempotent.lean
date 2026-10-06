-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.densityMatrix_idempotent
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
import Theorems.Thm_BookProof_ChapterEulerDensityMatrix_densityMatrix_eq
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    densityMatrix t * densityMatrix t = densityMatrix t := by

  rw [densityMatrix_eq]
  have h := Real.sin_sq_add_cos_sq t
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
  · linear_combination (Real.cos t ^ 2) * h
  · linear_combination (Real.cos t * Real.sin t) * h
  · linear_combination (Real.cos t * Real.sin t) * h
  · linear_combination (Real.sin t ^ 2) * h
