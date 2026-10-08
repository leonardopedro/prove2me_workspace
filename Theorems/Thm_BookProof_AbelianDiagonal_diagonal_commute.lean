-- Generated from ChapterAbelianDiagonal.lean — theorem BookProof.AbelianDiagonal.diagonal_commute
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal



open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.AbelianDiagonal.diagonal_commute (d e : n → ℂ) :
    Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d := by sorry
