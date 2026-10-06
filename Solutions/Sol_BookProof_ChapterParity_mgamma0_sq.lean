-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.mgamma0_sq
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : mgamma 0 * mgamma 0 = -1 := by

  have h : mgammaZ 0 * mgammaZ 0 = -1 := by decide
  have := congrArg (Int.castRingHom ℂ).mapMatrix h
  rwa [map_mul, map_neg, map_one, ← mgamma] at this
