-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylOp_apply
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.weylOp_apply {T : D →ₗ[ℂ] D}
    (hT : SymmetricOn D (D.subtype.comp T)) (x : D) :
    (inner ℂ (x : F) ((T (T x) : D) : F) : ℂ) = ((‖((T x : D) : F)‖ ^ 2 : ℝ) : ℂ) := by sorry
