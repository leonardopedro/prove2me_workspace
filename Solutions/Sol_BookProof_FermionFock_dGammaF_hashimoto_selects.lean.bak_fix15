-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaF_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaOpFB_symmetricOn
import Theorems.Thm_BookProof_FermionFock_dGammaOpFB_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_hashimoto_selects
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (ε : ℕ ≃ FConf) {col : ℕ → (ℕ →₀ ℂ)}
    (hherm : IsHermCol col) (hpos : IsPosCol col) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ FermiFock) (A : Dom →ₗ[ℂ] FermiFock) (R : FermiFock →L[ℂ] FermiFock),
      IsPositiveSelfAdjointExtension (dGammaOpFB ε col) A ∧ IsShiftInvert A γ R ∧
        ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : FermiFock, Tendsto (fun k : ℕ => galerkinCompression R (l2BasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : FermiFock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (l2BasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ FermiFock) (A' : Dom' →ₗ[ℂ] FermiFock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : FermiFock) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
            A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  friedrichs_hashimoto_selects (l2BasisN ε) (dGammaOpFB ε col)
      (dGammaOpFB_symmetricOn hherm) (dGammaOpFB_quadForm_nonneg hpos) hγ
