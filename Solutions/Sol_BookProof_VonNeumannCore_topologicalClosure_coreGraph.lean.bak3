-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.topologicalClosure_coreGraph
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_coreGraph_le_clGraph
import Theorems.Thm_BookProof_VonNeumannCore_mem_coreLp_iff
import Theorems.Thm_BookProof_VonNeumannCore_mem_clLp_iff
import Theorems.Thm_BookProof_VonNeumannCore_clLp_le_topologicalClosure_coreLp
import Theorems.Thm_BookProof_EsaClosure_clGraph_isClosed
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
    (hsym : SymmetricOn D A) : (coreGraph A).topologicalClosure = clGraph A := by

  refine le_antisymm
    (Submodule.topologicalClosure_minimal _ (coreGraph_le_clGraph A) (clGraph_isClosed A)) ?_
  intro p hp
  have hmem : (WithLp.toLp 2 p) ∈ (coreLp A).topologicalClosure :=
    clLp_le_topologicalClosure_coreLp A hdense hsym (by simpa [mem_clLp_iff] using hp)
  have hcont : Continuous fun z : WithLp 2 (F × F) => WithLp.ofLp z := by fun_prop
  have himg : (fun z : WithLp 2 (F × F) => WithLp.ofLp z) ''
      ((coreLp A : Submodule ℂ (WithLp 2 (F × F))) : Set (WithLp 2 (F × F)))
      = ((coreGraph A : Submodule ℂ (F × F)) : Set (F × F)) := by
    ext r
    constructor
    · rintro ⟨z, hz, rfl⟩
      exact hz
    · intro hr
      exact ⟨WithLp.toLp 2 r, by simpa [mem_coreLp_iff] using hr, by simp⟩
  have hsub := image_closure_subset_closure_image (f := fun z : WithLp 2 (F × F) => WithLp.ofLp z)
    hcont (s := ((coreLp A : Submodule ℂ (WithLp 2 (F × F))) : Set (WithLp 2 (F × F))))
  rw [himg] at hsub
  have hpmem : p ∈ closure ((coreGraph A : Submodule ℂ (F × F)) : Set (F × F)) := by
    refine hsub ⟨WithLp.toLp 2 p, ?_, by simp⟩
    rw [← Submodule.topologicalClosure_coe]
    exact hmem
  rwa [← Submodule.topologicalClosure_coe] at hpmem
