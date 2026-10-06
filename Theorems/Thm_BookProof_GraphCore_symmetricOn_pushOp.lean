-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.symmetricOn_pushOp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFarisLavineCore
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open BookProof.FarisLavine


theorem BookProof.GraphCore.symmetricOn_pushOp (U : F →ₗᵢ[ℂ] G) {D : Submodule ℂ F} (T : D →ₗ[ℂ] F)
    (hT : SymmetricOn D T) : SymmetricOn (pushDom U D) (pushOp U T) := by sorry
