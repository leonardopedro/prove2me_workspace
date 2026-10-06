-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.densityMatrix_eq
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    densityMatrix t =
      !![Real.cos t ^ 2, Real.cos t * Real.sin t;
         Real.cos t * Real.sin t, Real.sin t ^ 2] := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [densityMatrix, clockPsi, Matrix.vecMulVec_apply] <;> ring
