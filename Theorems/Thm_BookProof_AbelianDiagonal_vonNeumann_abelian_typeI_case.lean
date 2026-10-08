-- Generated from ChapterAbelianDiagonal.lean — theorem BookProof.AbelianDiagonal.vonNeumann_abelian_typeI_case
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal



open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.AbelianDiagonal.vonNeumann_abelian_typeI_case :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) ∧
      (∀ d e : n → ℂ,
        Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d) ∧
      (∀ M : Matrix n n ℂ,
        (∀ d : n → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) ↔
          ∃ e : n → ℂ, M = Matrix.diagonal e) := by sorry
