-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.pushDom_mono
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open BookProof.FarisLavine


theorem BookProof.GraphCore.pushDom_mono (U : F →ₗᵢ[ℂ] G) {D₁ D₂ : Submodule ℂ F} (h : D₁ ≤ D₂) :
    pushDom U D₁ ≤ pushDom U D₂ := by sorry
