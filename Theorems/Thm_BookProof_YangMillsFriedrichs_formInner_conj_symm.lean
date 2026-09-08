-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.formInner_conj_symm
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs


















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

theorem BookProof.YangMillsFriedrichs.formInner_conj_symm {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    (starRingEnd ℂ) (formInner H y x) = formInner H x y := by sorry
