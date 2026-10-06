-- Generated from ChapterSuperBracket.lean — theorem BookProof.ChapterSuperBracket.sbracket_graded_antisymm
import Mathlib
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterSuperBracket

variable {R : Type*} [Ring R]




theorem BookProof.ChapterSuperBracket.sbracket_graded_antisymm (p q : Bool) (a b : R) :
    sbracket p q a b = - (eps p q : R) * sbracket q p b a := by sorry
