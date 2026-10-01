-- Generated from ChapterFarisLavineCore.lean — theorem BookProof.FarisLavine.quadForm_im
import Mathlib
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavine
open BookProof.HashimotoShiftInvert
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}




theorem BookProof.FarisLavine.quadForm_im (N : D →ₗ[ℂ] F) (hN : SymmetricOn D N) (x : D) :
    (inner ℂ (x : F) (N x) : ℂ).im = 0 := by sorry
