-- Generated from ChapterSuperBracket.lean — solution of BookProof.ChapterSuperBracket.sbracket_odd_odd
import Mathlib
import Definitions.Def_ChapterSuperBracket
open BookProof.ChapterSuperBracket




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (a b : R) : sbracket true true a b = a * b + b * a := by

  simp only [sbracket, eps_true_true]
  push_cast
  noncomm_ring
