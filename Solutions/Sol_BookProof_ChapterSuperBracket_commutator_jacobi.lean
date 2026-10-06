-- Generated from ChapterSuperBracket.lean — solution of BookProof.ChapterSuperBracket.commutator_jacobi
import Mathlib
import Definitions.Def_ChapterSuperBracket
import Theorems.Thm_BookProof_ChapterSuperBracket_super_jacobi
open BookProof.ChapterSuperBracket




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (a b c : R) :
    sbracket false false a (sbracket false false b c)
  + sbracket false false b (sbracket false false c a)
  + sbracket false false c (sbracket false false a b) = 0 := by

  have h := super_jacobi (R := R) false false false a b c
  simpa using h
