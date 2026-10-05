-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.graded_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_gradedHamiltonianB_symmetricOn
import Theorems.Thm_BookProof_GradedHashimoto_gradedHamiltonianB_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_hashimoto_selects
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (ε : ℕ ≃ GConf) {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hbherm : IsHermCol colB) (hbpos : IsPosCol colB)
    (hfherm : IsHermCol colF) (hfpos : IsPosCol colF) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock) (R : GFock →L[ℂ] GFock),
      IsPositiveSelfAdjointExtension (gradedHamiltonianB ε colB colF) A ∧
        IsShiftInvert A γ R ∧ ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : GFock, Tendsto (fun k : ℕ => galerkinCompression R (l2BasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : GFock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (l2BasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ GFock) (A' : Dom' →ₗ[ℂ] GFock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : GFock) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
            A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  friedrichs_hashimoto_selects (l2BasisN ε) (gradedHamiltonianB ε colB colF)
      (gradedHamiltonianB_symmetricOn hbherm hfherm)
      (gradedHamiltonianB_quadForm_nonneg hbpos hfpos) hγ
