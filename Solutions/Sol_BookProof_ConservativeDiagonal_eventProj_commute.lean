-- Generated from ChapterConservativeDiagonal.lean — solution of BookProof.ConservativeDiagonal.eventProj_commute
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
open BookProof.ConservativeDiagonal



open scoped Matrix
open Matrix BookProof.FreeFieldConstraint


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (S T : Finset n) :
    eventProj S * eventProj T = eventProj T * eventProj S := by

  unfold eventProj
  rw [Matrix.diagonal_mul_diagonal, Matrix.diagonal_mul_diagonal]
  congr 1; funext k; ring
