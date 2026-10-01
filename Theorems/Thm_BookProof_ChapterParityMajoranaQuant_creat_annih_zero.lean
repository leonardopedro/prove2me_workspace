-- Generated from ChapterParityMajoranaQuant.lean — theorem BookProof.ChapterParityMajoranaQuant.creat_annih_zero
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant

variable {m : ℕ}
variable (J : Matrix (Fin m) (Fin m) ℂ)


open Matrix
open scoped ComplexConjugate



theorem BookProof.ChapterParityMajoranaQuant.creat_annih_zero (hJ2 : J * J = -1) : creatProj J * annihProj J = 0 := by sorry
