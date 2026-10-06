-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clExt_extends
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.clExt_extends (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (v : D) : clExt T hdense hsym ⟨(v : F), coe_mem_clDom T v⟩ = T v := by sorry
