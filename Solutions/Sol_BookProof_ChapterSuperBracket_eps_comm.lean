-- Generated from ChapterSuperBracket.lean — solution of BookProof.ChapterSuperBracket.eps_comm
import Mathlib
import Definitions.Def_ChapterSuperBracket
open BookProof.ChapterSuperBracket




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Bool) : eps p q = eps q p := by

  cases p <;> cases q <;> rfl
