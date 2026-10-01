-- Generated from ChapterNavierStokesHashimoto.lean — solution of BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension_unique
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_NSHashimoto_velCore_esa
import Theorems.Thm_BookProof_EsaClosure_isSelfAdjointExtension_unique_of_esa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto



open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {Dom₁ Dom₂ : Submodule ℂ (L2I Vel)}
    {G₁ : Dom₁ →ₗ[ℂ] L2I Vel} {G₂ : Dom₂ →ₗ[ℂ] L2I Vel}
    (h₁ : IsSelfAdjointExtension (velCore A c) G₁)
    (h₂ : IsSelfAdjointExtension (velCore A c) G₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : L2I Vel) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), G₁ ⟨x, h⟩ = G₂ ⟨x, h'⟩ := isSelfAdjointExtension_unique_of_esa (velCore_esa A c) h₁ h₂
