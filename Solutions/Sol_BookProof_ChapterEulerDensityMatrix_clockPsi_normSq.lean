-- Generated from ChapterEulerDensityMatrix.lean — solution of BookProof.ChapterEulerDensityMatrix.clockPsi_normSq
import Mathlib
import Definitions.Def_ChapterEulerDensityMatrix
open BookProof.ChapterEulerDensityMatrix



open scoped Matrix

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : clockPsi t ⬝ᵥ clockPsi t = 1 := by

  simp only [clockPsi, dotProduct, Fin.sum_univ_two, Matrix.cons_val_zero,
    Matrix.cons_val_one]
  nlinarith [Real.sin_sq_add_cos_sq t]
