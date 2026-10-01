-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.bracket_self
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint




variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (a : R) : bracket a a = 0 := by

  simp [bracket]
