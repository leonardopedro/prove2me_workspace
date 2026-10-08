-- Generated from ChapterAbelianDiagonal.lean — theorem BookProof.AbelianDiagonal.commutant_diagonal_eq_diagonal
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal



open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.AbelianDiagonal.commutant_diagonal_eq_diagonal (M : Matrix n n ℂ)
    (h : ∀ d : n → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) :
    M = Matrix.diagonal (fun i => M i i) := by sorry
