-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clExt_symmetricOn
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure










open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.EsaClosure.clExt_symmetricOn (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    SymmetricOn (clDom T) (clExt T hdense hsym) := by sorry
