-- Generated from ChapterAbelianDiagonal.lean — solution of BookProof.AbelianDiagonal.vonNeumann_abelian_typeI_case
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
import Theorems.Thm_BookProof_AbelianDiagonal_diagonalStarAlgHom_injective
import Theorems.Thm_BookProof_AbelianDiagonal_diagonal_commute
import Theorems.Thm_BookProof_AbelianDiagonal_commutant_diagonal_eq_diagonal
open BookProof.AbelianDiagonal




open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) ∧
      (∀ d e : n → ℂ,
        Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d) ∧
      (∀ M : Matrix n n ℂ,
        (∀ d : n → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) ↔
          ∃ e : n → ℂ, M = Matrix.diagonal e) := by

  refine ⟨diagonalStarAlgHom_injective, diagonal_commute, fun M => ⟨fun h => ?_, ?_⟩⟩
  · exact ⟨fun i => M i i, commutant_diagonal_eq_diagonal M h⟩
  · rintro ⟨e, rfl⟩ d
    exact diagonal_commute e d
