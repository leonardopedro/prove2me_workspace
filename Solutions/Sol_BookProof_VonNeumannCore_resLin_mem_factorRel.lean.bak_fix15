-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.resLin_mem_factorRel
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
theorem solution (A : D →ₗ[ℂ] F) (h : F) :
    (resLin A h, h - resLin A h) ∈ factorRel A := by

  have hmem := resPair_mem A h
  have hsum := resPair_add A h
  have : (resLin A h, h - resLin A h) = resPair A h := by
    rw [resLin_apply, Prod.ext_iff]
    exact ⟨rfl, (eq_sub_of_add_eq' hsum).symm⟩
  rw [this]; exact hmem
