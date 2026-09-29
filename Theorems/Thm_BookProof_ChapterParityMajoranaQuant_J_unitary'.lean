-- Generated from ChapterParityMajoranaQuant.lean — theorem BookProof.ChapterParityMajoranaQuant.J_unitary'
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant










open Matrix
open scoped ComplexConjugate


variable {m : ℕ}




variable (J : Matrix (Fin m) (Fin m) ℂ)

theorem BookProof.ChapterParityMajoranaQuant.J_unitary' (hJ2 : J * J = -1) (hskew : Jᴴ = -J) : J * Jᴴ = 1 := by sorry
