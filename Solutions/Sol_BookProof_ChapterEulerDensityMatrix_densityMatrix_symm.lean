-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.densityMatrix_symm
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
import Theorems.Thm_BookProof_ChapterEulerDensityMatrix_densityMatrix_eq
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : (densityMatrix t)ᵀ = densityMatrix t := by

  rw [densityMatrix_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp
