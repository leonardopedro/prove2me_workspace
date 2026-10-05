-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.clLp_le_topologicalClosure_coreLp
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_coreLp_le_clLp
import Theorems.Thm_BookProof_VonNeumannCore_clLp_isClosed
import Theorems.Thm_BookProof_VonNeumannCore_eq_zero_of_mem_clLp_of_orthogonal
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
    (hsym : SymmetricOn D A) : clLp A ≤ (coreLp A).topologicalClosure := by

  haveI : CompleteSpace ((coreLp A).topologicalClosure) :=
    (coreLp A).isClosed_topologicalClosure.completeSpace_coe
  haveI : ((coreLp A).topologicalClosure).HasOrthogonalProjection :=
    Submodule.HasOrthogonalProjection.ofCompleteSpace _
  intro v hv
  obtain ⟨a, ha, b, hb, hab⟩ :=
    Submodule.exists_add_mem_mem_orthogonal (K := (coreLp A).topologicalClosure) v
  have hKle : (coreLp A).topologicalClosure ≤ clLp A :=
    Submodule.topologicalClosure_minimal _ (coreLp_le_clLp A) (clLp_isClosed A)
  have hbcl : b ∈ clLp A := by
    have hb' : b = v - a := by rw [hab]; abel
    rw [hb']
    exact (clLp A).sub_mem hv (hKle ha)
  have hborth : b ∈ (coreLp A)ᗮ :=
    Submodule.orthogonal_le (Submodule.le_topologicalClosure _) hb
  have hb0 : b = 0 := eq_zero_of_mem_clLp_of_orthogonal A hdense hsym hbcl hborth
  rw [hab, hb0, add_zero]
  exact ha
