-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.resLin_left_inverse
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_resLin_apply
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (x : frDom A) :
    resLin A ((x : F) + frFun A x) = (x : F) := by

  rw [resLin_apply, resPair_unique (frFun_spec A x) rfl]
