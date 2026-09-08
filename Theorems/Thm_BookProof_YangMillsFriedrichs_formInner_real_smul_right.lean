-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.formInner_real_smul_right
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs


















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.YangMillsFriedrichs.formInner_real_smul_right (H : D →ₗ[ℂ] F) (t : ℝ) (x y : D) :
    formInner H x ((t : ℂ) • y) = (t : ℂ) * formInner H x y := by sorry
