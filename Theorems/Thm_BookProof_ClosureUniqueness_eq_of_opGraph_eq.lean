-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.eq_of_opGraph_eq
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}



open BookProof.FarisLavine BookProof.EsaClosure


theorem BookProof.ClosureUniqueness.eq_of_opGraph_eq {A : Dom₁ →ₗ[ℂ] F} {B : Dom₂ →ₗ[ℂ] F} (h : opGraph A = opGraph B) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h₁ : x ∈ Dom₁) (h₂ : x ∈ Dom₂), A ⟨x, h₁⟩ = B ⟨x, h₂⟩ := by sorry
