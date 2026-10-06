-- Generated from ChapterClosureUniqueness.lean — solution of BookProof.ClosureUniqueness.exists_isClosureOf
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Theorems.Thm_BookProof_ClosureUniqueness_clExt_isClosureOf
open BookProof.ClosureUniqueness




open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) : ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsClosureOf T A := ⟨clDom T, clExt T hdense hsym, clExt_isClosureOf T hdense hsym⟩
