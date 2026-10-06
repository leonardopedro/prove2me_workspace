-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.exists_isClosureOf
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}



open BookProof.FarisLavine BookProof.EsaClosure


theorem BookProof.ClosureUniqueness.exists_isClosureOf (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) : ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsClosureOf T A := by sorry
