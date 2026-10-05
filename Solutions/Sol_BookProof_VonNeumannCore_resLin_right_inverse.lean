-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.resLin_right_inverse
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_resLin_mem_factorRel
import Theorems.Thm_BookProof_VonNeumannCore_resCLM_mem_frDom
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) (h : F) :
    resLin A h + frFun A ⟨resLin A h, resCLM_mem_frDom A h⟩ = h := by

  have hval : frFun A ⟨resLin A h, resCLM_mem_frDom A h⟩ = h - resLin A h :=
    frFun_unique hdense hsym (resLin_mem_factorRel A h)
  rw [hval]
  abel
