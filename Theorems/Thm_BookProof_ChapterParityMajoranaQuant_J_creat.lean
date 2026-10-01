-- Generated from ChapterParityMajoranaQuant.lean — theorem BookProof.ChapterParityMajoranaQuant.J_creat
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant

variable {m : ℕ}
variable (J : Matrix (Fin m) (Fin m) ℂ)


open Matrix
open scoped ComplexConjugate



theorem BookProof.ChapterParityMajoranaQuant.J_creat (hJ2 : J * J = -1) : J * creatProj J = Complex.I • creatProj J := by sorry
