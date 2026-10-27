-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedNumber_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_graded_hashimoto_selects
import Theorems.Thm_BookProof_GradedFriedrichs_isHermCol_idCol
import Theorems.Thm_BookProof_GradedFriedrichs_isPosCol_idCol
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock) (R : GFock →L[ℂ] GFock),
      IsPositiveSelfAdjointExtension (gradedHamiltonianB gradedEnum idCol idCol) A ∧
        IsShiftInvert A γ R ∧ ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : GFock, Tendsto (fun k : ℕ => galerkinCompression R (l2BasisN gradedEnum) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : GFock,
          Tendsto (fun k : ℕ =>
            resolvent (galerkinCompression R (l2BasisN gradedEnum) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ GFock) (A' : Dom' →ₗ[ℂ] GFock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : GFock) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
            A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  graded_hashimoto_selects gradedEnum isHermCol_idCol isPosCol_idCol
      isHermCol_idCol isPosCol_idCol hγ
