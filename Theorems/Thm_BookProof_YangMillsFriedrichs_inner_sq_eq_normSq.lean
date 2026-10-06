-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.inner_sq_eq_normSq
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.inner_sq_eq_normSq {T : D →ₗ[ℂ] D}
    (hT : SymmetricOn D (D.subtype.comp T)) (x : D) :
    (inner ℂ (x : F) ((T (T x) : D) : F) : ℂ) = ((‖((T x : D) : F)‖ ^ 2 : ℝ) : ℂ) := by sorry
