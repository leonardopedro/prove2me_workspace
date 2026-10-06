-- Generated from ChapterAbelianDiagonal.lean — solution of BookProof.AbelianDiagonal.diagonalStarAlgHom_injective
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal




open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) := fun _ _ h => Matrix.diagonal_injective h
