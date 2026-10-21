-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.mem_opGraph
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (v : D) : ((v : F), T v) ∈ opGraph T := ⟨v, rfl⟩
