-- Generated from ChapterAbelianVonNeumannFinite.lean — solution of BookProof.ChapterAbelianVonNeumannFinite.conjDiagonal_injective
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
import Theorems.Thm_BookProof_ChapterAbelianVonNeumannFinite_diagonalStarAlgHom_injective
open BookProof.ChapterAbelianVonNeumannFinite



open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix.unitaryGroup n ℂ) :
    Function.Injective (conjDiagonal U) := by

  intro d d' h
  refine diagonalStarAlgHom_injective ?_
  simpa [conjDiagonal_apply] using
    (Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) U).injective h
