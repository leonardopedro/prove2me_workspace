-- Generated from ChapterConservativeDiagonal.lean — solution of BookProof.ConservativeDiagonal.eventProj_isDiag
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.ConservativeDiagonal



open scoped Matrix
open Matrix BookProof.FreeFieldConstraint


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]


@[simp] private theorem eventProj_apply (S : Finset n) (k l : n) :
    eventProj S k l = if k = l then (if k ∈ S then (1 : ℂ) else 0) else 0 := by
  simp [eventProj, Matrix.diagonal_apply]

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset n) : (eventProj S).IsDiag := by

  intro k l hkl; simp [eventProj_apply, hkl]
