-- Generated from ChapterSuperBracket.lean — solution of BookProof.ChapterSuperBracket.sbracket_even_even
import Mathlib
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterSuperBracket
open BookProof.ChapterElectroweakFieldStrength




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in

theorem solution (a b : R) : sbracket false false a b = a * b - b * a := by
  simp [sbracket]
