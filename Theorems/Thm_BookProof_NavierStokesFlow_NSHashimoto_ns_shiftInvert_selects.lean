-- Generated from ChapterNavierStokesHashimoto.lean — theorem BookProof.NavierStokesFlow.NSHashimoto.ns_shiftInvert_selects
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

theorem BookProof.NavierStokesFlow.NSHashimoto.ns_shiftInvert_selects {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel) (X : L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧ IsShiftInvertC G γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ Dom = LinearMap.range ((X : L2I Vel →ₗ[ℂ] L2I Vel)) ∧
      (∀ (Dom' : Submodule ℂ (L2I Vel)) (G' : Dom' →ₗ[ℂ] L2I Vel), IsShiftInvertC G' γ X →
        Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by sorry
