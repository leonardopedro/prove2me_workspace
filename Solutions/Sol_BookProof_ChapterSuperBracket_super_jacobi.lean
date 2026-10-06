-- Generated from ChapterSuperBracket.lean — solution of BookProof.ChapterSuperBracket.super_jacobi
import Mathlib
import Definitions.Def_ChapterSuperBracket
open BookProof.ChapterSuperBracket




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (p q r : Bool) (a b c : R) :
    (eps p r : R) * sbracket p (xor q r) a (sbracket q r b c)
  + (eps q p : R) * sbracket q (xor r p) b (sbracket r p c a)
  + (eps r q : R) * sbracket r (xor p q) c (sbracket p q a b) = 0 := by

  cases p <;> cases q <;> cases r <;>
    · simp only [sbracket, eps, Bool.and_true, Bool.and_false, Bool.xor_true,
        Bool.xor_false, Bool.not_true, Bool.not_false]
      push_cast
      noncomm_ring
