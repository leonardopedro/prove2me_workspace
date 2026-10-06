-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.norm_add_I_eq_norm_sub_I
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
variable [CompleteSpace F] {Dom : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.norm_add_I_eq_norm_sub_I {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A) (x : Dom) :
    ‖A x + Complex.I • (x : F)‖ = ‖A x - Complex.I • (x : F)‖ := by sorry
