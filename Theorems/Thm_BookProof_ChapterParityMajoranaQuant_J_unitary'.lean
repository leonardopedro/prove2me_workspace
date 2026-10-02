-- Generated from ChapterParityMajoranaQuant.lean — theorem BookProof.ChapterParityMajoranaQuant.J_unitary'
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant

variable {m : ℕ}
variable (J : Matrix (Fin m) (Fin m) ℂ)


open Matrix
open scoped ComplexConjugate



theorem BookProof.ChapterParityMajoranaQuant.J_unitary_prime (hJ2 : J * J = -1) (hskew : Jᴴ = -J) : J * Jᴴ = 1 := by sorry
