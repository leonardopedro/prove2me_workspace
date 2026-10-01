-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clShift_surjective
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


h0
  linear_combination -h0

theorem BookProof.EsaClosure.clShift_surjective (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (hesa : EssentiallySelfAdjointOn D T) :
    Function.Surjective (cshiftMap (clE := by sorry
