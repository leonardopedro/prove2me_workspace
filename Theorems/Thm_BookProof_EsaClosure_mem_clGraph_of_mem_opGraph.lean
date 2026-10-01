-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.mem_clGraph_of_mem_opGraph
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.mem_clGraph_of_mem_opGraph {T : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ opGraph T) :
    p ∈ clGraph T := by sorry
