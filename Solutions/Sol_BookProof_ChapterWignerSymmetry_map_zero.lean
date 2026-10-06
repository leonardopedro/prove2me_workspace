-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.map_zero
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry



open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) : T 0 = 0 := by

  have := norm_map hT 0
  simpa using this
