-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.formInner_real_smul_left
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.formInner_real_smul_left (H : D →ₗ[ℂ] F) (t : ℝ) (x y : D) :
    formInner H ((t : ℂ) • x) y = (t : ℂ) * formInner H x y := by sorry
