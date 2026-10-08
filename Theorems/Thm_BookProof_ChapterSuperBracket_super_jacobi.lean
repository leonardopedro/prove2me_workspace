-- Generated from ChapterSuperBracket.lean — theorem BookProof.ChapterSuperBracket.super_jacobi
import Mathlib
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterSuperBracket



variable {R : Type*} [Ring R]


theorem BookProof.ChapterSuperBracket.super_jacobi (p q r : Bool) (a b c : R) :
    (eps p r : R) * sbracket p (xor q r) a (sbracket q r b c)
  + (eps q p : R) * sbracket q (xor r p) b (sbracket r p c a)
  + (eps r q : R) * sbracket r (xor p q) c (sbracket p q a b) = 0 := by sorry
