-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.closure_unique
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.closure_unique {T : D →ₗ[ℂ] F} {A : Dom₁ →ₗ[ℂ] F} {B : Dom₂ →ₗ[ℂ] F}
    (hA : IsClosureOf T A) (hB : IsClosureOf T B) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h₁ : x ∈ Dom₁) (h₂ : x ∈ Dom₂), A ⟨x, h₁⟩ = B ⟨x, h₂⟩ := by sorry
