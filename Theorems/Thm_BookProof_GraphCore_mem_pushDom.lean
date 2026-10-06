-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.mem_pushDom
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open BookProof.FarisLavine


theorem BookProof.GraphCore.mem_pushDom (U : F →ₗᵢ[ℂ] G) {D : Submodule ℂ F} (x : D) :
    U (x : F) ∈ pushDom U D := by sorry
