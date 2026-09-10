-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dGamma_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOpB_symmetricOn
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOpB_quadForm_nonneg
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (ε : ℕ ≃ Conf) {col : ℕ → (ℕ →₀ ℂ)}
    (hherm : IsHermCol col) (hpos : IsPosCol col) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock) (R : Fock →L[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOpB ε col) A ∧ IsShiftInvert A γ R ∧
        ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : Fock, Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : Fock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ Fock) (A' : Dom' →ₗ[ℂ] Fock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : Fock) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  friedrichs_hashimoto_selects (fockBasisN ε) (dGammaOpB ε col)
      (dGammaOpB_symmetricOn hherm) (dGammaOpB_quadForm_nonneg hpos) hγ
