-- Generated from ChapterAbelianVonNeumannFinite.lean — theorem BookProof.ChapterAbelianVonNeumannFinite.diagonalStarAlgHom_injective
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal
open BookProof.ChapterAbelianVonNeumannFinite


open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterAbelianVonNeumannFinite.diagonalStarAlgHom_injective :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) := by sorry
