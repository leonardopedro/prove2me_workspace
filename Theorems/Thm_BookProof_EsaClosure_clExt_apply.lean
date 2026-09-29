-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clExt_apply
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure










open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.EsaClosure.clExt_apply (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (x : clDom T) : clExt T hdense hsym x = clFun T x := by sorry
