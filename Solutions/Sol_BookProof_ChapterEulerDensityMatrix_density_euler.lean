-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.density_euler
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
import Theorems.Thm_BookProof_ChapterEulerDensityMatrix_densityMatrix_eq
import Theorems.Thm_BookProof_ChapterEulerDensityMatrix_euler_rhs
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    densityMatrix t =
      (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + Zdiag * ((Real.cos (2 * t)) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
            + (Real.sin (2 * t)) • Jdens) := by

  rw [densityMatrix_eq, euler_rhs]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Real.cos_two_mul, Real.sin_two_mul, Real.sin_sq] <;> ring
