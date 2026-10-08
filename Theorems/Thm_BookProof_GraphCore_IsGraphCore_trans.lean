-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.IsGraphCore.trans
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.GraphCore.IsGraphCore.trans {D₁ D₂ D₃ : Submodule ℂ F} {T : D₃ →ₗ[ℂ] F}
    (h₂₃ : D₂ ≤ D₃) (h₁ : IsGraphCore D₁ (restrictOp T h₂₃)) (h₂ : IsGraphCore D₂ T) :
    IsGraphCore D₁ T := by sorry
