-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.mem_clGraph_of_mem_opGraph
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]
variable [CompleteSpace F] {Dom : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.EsaClosure.mem_clGraph_of_mem_opGraph {T : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ opGraph T) :
    p ∈ clGraph T := by sorry
