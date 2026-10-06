-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.density_collapse
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
import Theorems.Thm_BookProof_ChapterEulerDensityMatrix_densityMatrix_eq
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    densityMatrix t - (Real.sin (2 * t)) • (Zdiag * Jdens)
      = !![Real.cos t ^ 2, 0; 0, Real.sin t ^ 2] := by

  rw [densityMatrix_eq, show Zdiag = !![1 / 2, 0; 0, -1 / 2] from rfl, Jdens,
    Matrix.mul_fin_two]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Real.sin_two_mul] <;> ring
