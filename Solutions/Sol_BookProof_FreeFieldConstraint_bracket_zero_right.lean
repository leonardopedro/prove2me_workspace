-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.bracket_zero_right
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint




variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (a : R) : bracket a (0 : R) = 0 := by

  simp [bracket]
