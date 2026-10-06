-- Generated from ChapterClosureUniqueness.lean — solution of BookProof.ClosureUniqueness.mem_factorGraph_sqOp
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Theorems.Thm_BookProof_ClosureUniqueness_mem_adjGraph_iff
import Theorems.Thm_BookProof_EsaClosure_mem_clGraph_of_mem_opGraph
import Theorems.Thm_BookProof_EsaClosure_mem_opGraph
open BookProof.ClosureUniqueness




open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hsym : SymmetricOn D A)
    (hstab : ∀ v : D, (A v : F) ∈ D) (v : D) :
    ((v : F), sqOp A hstab v) ∈ factorGraph A := by

  refine ⟨A v, mem_clGraph_of_mem_opGraph (mem_opGraph A v), ?_⟩
  rw [mem_adjGraph_iff]
  intro u
  have h := hsym u ⟨A v, hstab v⟩
  simpa using h
