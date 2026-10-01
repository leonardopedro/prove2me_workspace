-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clExt_extends
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]
variable [CompleteSpace F] {Dom : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

e hsym x = clFun T x := rfl

theorem BookProof.EsaClosure.clExt_extends (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (v : D) : clExt T hdense hsym ⟨(v : F) := by sorry
