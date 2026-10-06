-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.coe_mem_clDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.coe_mem_clDom (T : D →ₗ[ℂ] F) (v : D) : (v : F) ∈ clDom T := by sorry
