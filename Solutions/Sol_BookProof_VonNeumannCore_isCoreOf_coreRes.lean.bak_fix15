-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.isCoreOf_coreRes
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_coreRes_apply
import Theorems.Thm_BookProof_VonNeumannCore_clGraph_coreRes
import Theorems.Thm_BookProof_ClosureUniqueness_opGraph_clExt
import Theorems.Thm_BookProof_FriedrichsSquare_frDom_le_clDom
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    IsCoreOf (coreRes A hdense hsym) (clExt A hdense hsym) := by

  constructor
  · intro x
    refine ⟨frDom_le_clDom A x.2, ?_⟩
    rw [coreRes_apply]
    rfl
  · rw [clGraph_coreRes A hdense hsym, opGraph_clExt A hdense hsym]
