-- Generated from ChapterSuperBracket.lean — solution of BookProof.ChapterSuperBracket.sbracket_graded_antisymm
import Mathlib
import Definitions.Def_ChapterSuperBracket
open BookProof.ChapterSuperBracket




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Bool) (a b : R) :
    sbracket p q a b = - (eps p q : R) * sbracket q p b a := by

  cases p <;> cases q <;>
    · simp only [sbracket, eps, Bool.and_true, Bool.and_false]
      push_cast
      noncomm_ring
