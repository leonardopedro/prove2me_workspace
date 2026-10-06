-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clExt_extends
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_mem_opGraph
import Theorems.Thm_BookProof_EsaClosure_mem_clGraph_of_mem_opGraph
import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (v : D) : clExt T hdense hsym ⟨(v : F), coe_mem_clDom T v⟩ = T v :=
  , coe_mem_clDom T v⟩ = T v :=
    clFun_unique hdense hsym (mem_clGraph_of_m
