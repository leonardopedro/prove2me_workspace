-- Generated from ChapterParityMajoranaQuant.lean — theorem BookProof.ChapterParityMajoranaQuant.iJ_herm
import Mathlib
import Definitions.Def_ChapterParityMajoranaQuant
open BookProof.ChapterParityMajoranaQuant

variable {m : ℕ}
variable (J : Matrix (Fin m) (Fin m) ℂ)


open Matrix
open scoped ComplexConjugate



theorem BookProof.ChapterParityMajoranaQuant.iJ_herm (hskew : Jᴴ = -J) : (iJ J)ᴴ = iJ J := by sorry
