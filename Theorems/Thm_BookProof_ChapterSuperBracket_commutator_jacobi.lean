-- Generated from ChapterSuperBracket.lean — theorem BookProof.ChapterSuperBracket.commutator_jacobi
import Mathlib
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterSuperBracket

variable {R : Type*} [Ring R]




theorem BookProof.ChapterSuperBracket.commutator_jacobi (a b c : R) :
    sbracket false false a (sbracket false false b c)
  + sbracket false false b (sbracket false false c a)
  + sbracket false false c (sbracket false false a b) = 0 := by sorry
