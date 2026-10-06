-- Generated from ChapterGraphCoreTransfer.lean — solution of BookProof.GraphCore.mem_pushDom
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore




open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution (U : F →ₗᵢ[ℂ] G) {D : Submodule ℂ F} (x : D) :
    U (x : F) ∈ pushDom U D := ⟨(x : F), x.2, rfl⟩
