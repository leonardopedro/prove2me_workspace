-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.map_zero
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}


theorem BookProof.ChapterWignerSymmetry.map_zero (hT : IsWignerSymmetry T) : T 0 = 0 := by sorry
