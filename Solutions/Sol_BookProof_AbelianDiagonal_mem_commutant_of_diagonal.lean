-- Generated from ChapterAbelianDiagonal.lean — solution of BookProof.AbelianDiagonal.mem_commutant_of_diagonal
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
import Theorems.Thm_BookProof_AbelianDiagonal_diagonal_commute
open BookProof.AbelianDiagonal




open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (e : n → ℂ) (d : n → ℂ) :
    Matrix.diagonal e * Matrix.diagonal d = Matrix.diagonal d * Matrix.diagonal e := diagonal_commute e d
