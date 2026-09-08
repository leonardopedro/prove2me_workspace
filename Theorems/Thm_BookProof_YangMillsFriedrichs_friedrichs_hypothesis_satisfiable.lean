-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.friedrichs_hypothesis_satisfiable
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs


















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}





















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}












variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.YangMillsFriedrichs.friedrichs_hypothesis_satisfiable (H : (⊤ : Submodule ℂ F) →ₗ[ℂ] F)
    (hsym : SymmetricOn (⊤ : Submodule ℂ F) H)
    (hpos : ∀ x : (⊤ : Submodule ℂ F), 0 ≤ quadForm H x) :
    IsPositiveSelfAdjointExtension H H := by sorry
