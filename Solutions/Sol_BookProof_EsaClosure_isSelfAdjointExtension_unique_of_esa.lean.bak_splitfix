-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.isSelfAdjointExtension_unique_of_esa
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_selfAdjointExtension_eq_adjoint
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {Dom₁ Dom₂ : Submodule ℂ F} {T : D →ₗ[ℂ] F}
    {A₁ : Dom₁ →ₗ[ℂ] F} {A₂ : Dom₂ →ₗ[ℂ] F} (hesa : EssentiallySelfAdjointOn D T)
    (h₁ : IsSelfAdjointExtension T A₁) (h₂ : IsSelfAdjointExtension T A₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), A₁ ⟨x, h⟩ = A₂ ⟨x, h'⟩ :=
  A₁ ⟨x, h⟩ = A₂ ⟨x, h'⟩ := by
    have key : ∀ (x : F) (h : x ∈ Dom₁), ∃ h' : x ∈ Dom₂, A₂ ⟨x, h'⟩ = A₁ ⟨x, h⟩ := by
      intro x h
      exact (selfAdjointExtension_eq_adjoint hesa h₂ x (A₁ ⟨x, h⟩)).1
        ((selfAdjointExtension_eq_adjoint hesa h₁ x (A₁ ⟨x, h⟩)).2 ⟨h, rfl⟩)
    have key' : ∀ (x : F) (h : x ∈ Dom₂), ∃ h' : x ∈ Dom₁, A₁ ⟨x, h'⟩ = A₂ ⟨x, h⟩ := by
      intro x h
      exact (selfAdjointExtension_eq_adjoint hesa h₁ x (A₂ ⟨x, h⟩)).1
        ((selfAdjointExtension_eq_adjoint hesa h₂ x (A₂ ⟨x, h⟩)).2 ⟨h, rfl⟩)
    refine ⟨?_, ?_⟩
    · apply le_antisymm
      · intro x hx; exact (key x hx).choose
      · intro x hx; exact (key' x hx).choose
    · intro x h h'
      obtain ⟨hx₂, hva
