-- Generated from ChapterNavierStokesHashimoto.lean — theorem BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension_unique
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.EsaClosure
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato


theorem BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension_unique {Dom₁ Dom₂ : Submodule ℂ (L2I Vel)}
    {G₁ : Dom₁ →ₗ[ℂ] L2I Vel} {G₂ : Dom₂ →ₗ[ℂ] L2I Vel}
    (h₁ : IsSelfAdjointExtension (velCore A c) G₁)
    (h₂ : IsSelfAdjointExtension (velCore A c) G₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : L2I Vel) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), G₁ ⟨x, h⟩ = G₂ ⟨x, h'⟩ := by sorry
