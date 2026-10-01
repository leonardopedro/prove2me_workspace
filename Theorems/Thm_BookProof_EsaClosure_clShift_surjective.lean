-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clShift_surjective
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

h0
  linear_combination -h0

theorem BookProof.EsaClosure.clShift_surjective (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (hesa : EssentiallySelfAdjointOn D T) :
    Function.Surjective (cshiftMap (clE := by sorry
