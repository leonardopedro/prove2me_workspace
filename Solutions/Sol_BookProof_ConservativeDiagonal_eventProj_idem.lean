-- Generated from ChapterConservativeDiagonal.lean — solution of BookProof.ConservativeDiagonal.eventProj_idem
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
open BookProof.ConservativeDiagonal



open scoped Matrix
open Matrix BookProof.FreeFieldConstraint


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset n) : eventProj S * eventProj S = eventProj S := by

  unfold eventProj
  rw [Matrix.diagonal_mul_diagonal]
  congr 1; funext k; by_cases h : k ∈ S <;> simp [h]
