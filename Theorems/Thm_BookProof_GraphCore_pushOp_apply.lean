-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.pushOp_apply
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open BookProof.FarisLavine


theorem BookProof.GraphCore.pushOp_apply (U : F →ₗᵢ[ℂ] G) {D : Submodule ℂ F} (T : D →ₗ[ℂ] F)
    (x : pushDom U D) (x₀ : D) (hx : (x : G) = U (x₀ : F)) :
    pushOp U T x = U (T x₀) := by sorry
