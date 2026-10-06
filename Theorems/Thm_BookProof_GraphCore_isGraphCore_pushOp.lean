-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.isGraphCore_pushOp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open BookProof.FarisLavine


theorem BookProof.GraphCore.isGraphCore_pushOp (U : F →ₗᵢ[ℂ] G) {D₁ D₂ : Submodule ℂ F} (T : D₂ →ₗ[ℂ] F)
    (hcore : IsGraphCore D₁ T) : IsGraphCore (pushDom U D₁) (pushOp U T) := by sorry
