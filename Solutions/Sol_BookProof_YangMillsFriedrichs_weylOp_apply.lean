-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.weylOp_apply
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs




open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {T : D →ₗ[ℂ] D}
    (hT : SymmetricOn D (D.subtype.comp T)) (x : D) :
    (inner ℂ (x : F) ((T (T x) : D) : F) : ℂ) = ((‖((T x : D) : F)‖ ^ 2 : ℝ) : ℂ) := 
