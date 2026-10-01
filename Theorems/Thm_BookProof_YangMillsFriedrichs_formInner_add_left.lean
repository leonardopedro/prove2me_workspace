-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.formInner_add_left
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open BookProof.FarisLavine




theorem BookProof.YangMillsFriedrichs.formInner_add_left (H : D →ₗ[ℂ] F) (x y z : D) :
    formInner H (x + y) z = formInner H x z + formInner H y z := by sorry
