-- Generated from ChapterClosureUniqueness.lean — solution of BookProof.ClosureUniqueness.clExt_isClosureOf
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Theorems.Thm_BookProof_ClosureUniqueness_opGraph_clExt
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_EsaClosure_clGraph_isClosed
import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom
open BookProof.ClosureUniqueness




open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    IsClosureOf T (clExt T hdense hsym) := by

  refine ⟨⟨fun v => ⟨coe_mem_clDom T v, clExt_extends T hdense hsym v⟩, ?_⟩, ?_⟩
  · rw [opGraph_clExt T hdense hsym]
    exact clGraph_isClosed T
  · rw [opGraph_clExt T hdense hsym]
