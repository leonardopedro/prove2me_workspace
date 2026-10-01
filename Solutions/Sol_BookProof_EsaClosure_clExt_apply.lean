-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clExt_apply
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
c T x)
    simpa using this

theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (x : clDom T) : clExt := T hde
