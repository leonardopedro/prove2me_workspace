-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.norm_sub_I_sq
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterFarisLavineCore
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ScalaronFiberFL.norm_sub_I_sq {D : Submodule ℂ F} (N : D →ₗ[ℂ] F)
    (hsym : SymmetricOn D N) (u : D) :
    ‖N u - Complex.I • (u : F)‖ ^ 2 = ‖N u‖ ^ 2 + ‖(u : F)‖ ^ 2 := by sorry
