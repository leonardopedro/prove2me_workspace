-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.eq_clExt_of_isClosureOf
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


theorem BookProof.ClosureUniqueness.eq_clExt_of_isClosureOf {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F} (hA : IsClosureOf T A)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    Dom = clDom T ∧ ∀ (x : F) (h₁ : x ∈ Dom) (h₂ : x ∈ clDom T),
      A ⟨x, h₁⟩ = clExt T hdense hsym ⟨x, h₂⟩ := by sorry
