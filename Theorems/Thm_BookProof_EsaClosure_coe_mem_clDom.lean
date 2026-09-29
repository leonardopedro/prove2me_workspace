-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.coe_mem_clDom
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure










open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.EsaClosure.coe_mem_clDom (T : D →ₗ[ℂ] F) (v : D) : (v : F) ∈ clDom T := by sorry
