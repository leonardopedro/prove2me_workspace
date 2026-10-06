-- Generated from ChapterAbelianDiagonal.lean — solution of BookProof.AbelianDiagonal.diagonal_commute
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal




open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (d e : n → ℂ) :
    Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d := by

  rw [Matrix.diagonal_mul_diagonal, Matrix.diagonal_mul_diagonal]
  simp [mul_comm]
