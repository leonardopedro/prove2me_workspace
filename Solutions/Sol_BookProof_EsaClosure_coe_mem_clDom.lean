-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.coe_mem_clDom
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_mem_opGraph
import Theorems.Thm_BookProof_EsaClosure_mem_clGraph_of_mem_opGraph
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
exact ⟨(x, y), hy, rfl⟩

theorem solution (T : D →ₗ[ℂ] F) ( :=
  v : D) : (v : F) ∈ clDom T :=
    mem_clDom_iff.2 ⟨T v, mem_clGraph_of_mem
