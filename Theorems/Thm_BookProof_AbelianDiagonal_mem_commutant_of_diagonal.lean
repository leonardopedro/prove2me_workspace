-- Generated from ChapterAbelianDiagonal.lean — theorem BookProof.AbelianDiagonal.mem_commutant_of_diagonal
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal



open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.AbelianDiagonal.mem_commutant_of_diagonal (e : n → ℂ) (d : n → ℂ) :
    Matrix.diagonal e * Matrix.diagonal d = Matrix.diagonal d * Matrix.diagonal e := by sorry
