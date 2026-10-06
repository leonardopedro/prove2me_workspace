-- Generated from ChapterAbelianDiagonal.lean — theorem BookProof.AbelianDiagonal.diagonalStarAlgHom_injective
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal

variable {n : Type*} [Fintype n] [DecidableEq n]



open Matrix


theorem BookProof.AbelianDiagonal.diagonalStarAlgHom_injective :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) := by sorry
