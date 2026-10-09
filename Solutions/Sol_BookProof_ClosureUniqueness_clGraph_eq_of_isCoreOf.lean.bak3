-- Generated from ChapterClosureUniqueness.lean — solution of BookProof.ClosureUniqueness.clGraph_eq_of_isCoreOf
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Theorems.Thm_BookProof_ClosureUniqueness_opGraph_le_of_extends
import Theorems.Thm_BookProof_EsaClosure_clGraph_isClosed
import Theorems.Thm_BookProof_EsaClosure_mem_opGraph
open BookProof.ClosureUniqueness




open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F} (h : IsCoreOf T₁ T₂) :
    clGraph T₁ = clGraph T₂ := by

  refine le_antisymm ?_ ?_
  · exact Submodule.topologicalClosure_mono (opGraph_le_of_extends h.1)
  · intro p hp
    refine clGraph_subset_of_isClosed (clGraph_isClosed T₁) (fun v => ?_) hp
    exact h.2 (mem_opGraph T₂ v)
