-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.isSelfAdjointExtension_unique_of_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable [CompleteSpace F]

theorem BookProof.EsaClosure.isSelfAdjointExtension_unique_of_esa {Dom₁ Dom₂ : Submodule ℂ F} {T : D →ₗ[ℂ] F}
    {A₁ : Dom₁ →ₗ[ℂ] F} {A₂ : Dom₂ →ₗ[ℂ] F} (hesa : EssentiallySelfAdjointOn D T)
    (h₁ : IsSelfAdjointExtension T A₁) (h₂ : IsSelfAdjointExtension T A₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), A₁ ⟨x, h⟩ = A₂ ⟨x, h'⟩ := by sorry
