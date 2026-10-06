-- Generated from ChapterAbelianVonNeumannFinite.lean — solution of BookProof.ChapterAbelianVonNeumannFinite.diagonalStarAlgHom_injective
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
open BookProof.ChapterAbelianVonNeumannFinite



open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective (diagonalStarAlgHom : (n → ℂ) →⋆ₐ[ℂ] Matrix n n ℂ) := by

  intro d d' h
  funext i
  have := congrFun (congrFun h i) i
  simpa using this
