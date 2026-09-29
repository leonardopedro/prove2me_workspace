-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clExt_symmetricOn
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_clGraph_inner_pair
open BookProof.EsaClosure











open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    SymmetricOn (clDom T) (clExt T hdense hsym) :=
  fun x y =>
    clGraph_inner_pair hsym (clFun_spec T x) (clFun_spec T y)
