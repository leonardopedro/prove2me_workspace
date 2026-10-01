-- Generated from ChapterFarisLavineCore.lean — theorem BookProof.FarisLavine.inner_im_swap
import Mathlib
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}




theorem BookProof.FarisLavine.inner_im_swap (a b : F) : (inner ℂ b a : ℂ).im = -(inner ℂ a b : ℂ).im := by sorry
