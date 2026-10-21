-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.opGraph_coreRes
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_mem_coreGraph_iff
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
    opGraph (coreRes A hdense hsym) = coreGraph A := by

  refine le_antisymm ?_ ?_
  · rintro p ⟨x, rfl⟩
    exact ⟨clFun_spec A ⟨(x : F), frDom_le_clDom A x.2⟩, x.2⟩
  · intro p hp
    obtain ⟨hpc, hpd⟩ := mem_coreGraph_iff.1 hp
    refine ⟨⟨p.1, hpd⟩, ?_⟩
    have hval : clFun A ⟨p.1, frDom_le_clDom A hpd⟩ = p.2 :=
      clFun_unique hdense hsym (by simpa using hpc)
    simp [coreRes_apply, hval]
