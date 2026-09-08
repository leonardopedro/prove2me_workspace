-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.formNormSq_add_smul
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs


















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.YangMillsFriedrichs.formNormSq_add_smul {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (t : ℝ) (x y : D) :
    formNormSq H (x + (t : ℂ) • y)
      = formNormSq H x + 2 * t * (formInner H x y).re + t ^ 2 * formNormSq H y := by sorry
