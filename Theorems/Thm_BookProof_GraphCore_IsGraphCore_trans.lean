-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.IsGraphCore.trans
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine


theorem BookProof.GraphCore.IsGraphCore.trans {D₁ D₂ D₃ : Submodule ℂ F} {T : D₃ →ₗ[ℂ] F}
    (h₂₃ : D₂ ≤ D₃) (h₁ : IsGraphCore D₁ (restrictOp T h₂₃)) (h₂ : IsGraphCore D₂ T) :
    IsGraphCore D₁ T := by sorry
