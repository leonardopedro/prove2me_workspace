-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.mem_clGraph_of_mem_opGraph
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_opGraph_le_clGraph
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {T : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ opGraph T) :
    p ∈ clGraph T := opGraph_le_clGraph T hp
