-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.map_zero
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.map_zero (hT : IsWignerSymmetry T) : T 0 = 0 := by sorry
