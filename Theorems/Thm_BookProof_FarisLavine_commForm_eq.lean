-- Generated from ChapterFarisLavineCore.lean — theorem BookProof.FarisLavine.commForm_eq
import Mathlib
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavine
open BookProof.HashimotoShiftInvert
open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


theorem BookProof.FarisLavine.commForm_eq (H N : D →ₗ[ℂ] F) (x : D) :
    commForm H N x = -2 * (inner ℂ (H x) (N x) : ℂ).im := by sorry
