-- Generated from ChapterParityMajoranaQuant.lean — theorem BookProof.ChapterParityMajoranaQuant.annihProj_herm
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant

variable {m : ℕ}
variable (J : Matrix (Fin m) (Fin m) ℂ)


open Matrix
open scoped ComplexConjugate



theorem BookProof.ChapterParityMajoranaQuant.annihProj_herm (hskew : Jᴴ = -J) : (annihProj J)ᴴ = annihProj J := by sorry
