-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.ym_fock_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open Filter Topology
















open BookProof.YangMillsHermite BookProof.HermiteProductCore
open Filter Topology

theorem BookProof.FockSecondQuantization.ym_fock_hashimoto_selects (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ε : ℕ ≃ Conf) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock) (R : Fock →L[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOpB ε (ymFockCol e fabc)) A ∧
        IsShiftInvert A γ R ∧ ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : Fock, Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : Fock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ Fock) (A' : Dom' →ₗ[ℂ] Fock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : Fock) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by sorry
