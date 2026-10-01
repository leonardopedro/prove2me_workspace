-- Generated from ChapterNavierStokesHashimoto.lean — theorem BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension_unique
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension_unique {Dom₁ Dom₂ : Submodule ℂ (L2I Vel)}
    {G₁ : Dom₁ →ₗ[ℂ] L2I Vel} {G₂ : Dom₂ →ₗ[ℂ] L2I Vel}
    (h₁ : IsSelfAdjointExtension (velCore A c) G₁)
    (h₂ : IsSelfAdjointExtension (velCore A c) G₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : L2I Vel) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), G₁ ⟨x, h⟩ = G₂ ⟨x, h'⟩ := by sorry
