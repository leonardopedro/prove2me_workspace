-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.re_formInner_swap
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs


















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.YangMillsFriedrichs.re_formInner_swap {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    (formInner H y x).re = (formInner H x y).re := by sorry
