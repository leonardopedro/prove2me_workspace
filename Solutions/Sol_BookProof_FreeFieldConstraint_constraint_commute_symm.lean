-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.constraint_commute_symm
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
import Theorems.Thm_BookProof_FreeFieldConstraint_bracket_antisymm
open BookProof.FreeFieldConstraint




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D H : R) : bracket D H = 0 ↔ bracket H D = 0 := by

  constructor <;> intro h
  · rw [bracket_antisymm, h, neg_zero]
  · rw [bracket_antisymm, h, neg_zero]
