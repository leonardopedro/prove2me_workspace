-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedSecondQuantization_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_graded_hashimoto_selects
import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol
import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {F G : Type*}
    [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [NormedAddCommGroup G] [InnerProductSpace ℂ G]
    (ε : ℕ ≃ GConf) (bB : HilbertBasis ℕ ℂ F) (bF : HilbertBasis ℕ ℂ G)
    (A : finiteModeDomain bB →ₗ[ℂ] finiteModeDomain bB)
    (B : finiteModeDomain bF →ₗ[ℂ] finiteModeDomain bF)
    (hA : SymmetricOn (finiteModeDomain bB) ((finiteModeDomain bB).subtype.comp A))
    (hAp : ∀ x, 0 ≤ quadForm ((finiteModeDomain bB).subtype.comp A) x)
    (hB : SymmetricOn (finiteModeDomain bF) ((finiteModeDomain bF).subtype.comp B))
    (hBp : ∀ x, 0 ≤ quadForm ((finiteModeDomain bF).subtype.comp B) x)
    {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ GFock) (A' : Dom →ₗ[ℂ] GFock) (R : GFock →L[ℂ] GFock),
      IsPositiveSelfAdjointExtension
          (gradedHamiltonianB ε (opCol bB A) (opCol bF B)) A' ∧
        IsShiftInvert A' γ R ∧ ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : GFock, Tendsto (fun k : ℕ => galerkinCompression R (l2BasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : GFock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (l2BasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ GFock) (A'' : Dom' →ₗ[ℂ] GFock), IsShiftInvert A'' γ R →
          Dom' = Dom ∧ ∀ (x : GFock) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
            A'' ⟨x, hx'⟩ = A' ⟨x, hx⟩) :=
  graded_hashimoto_selects ε (isHermCol_opCol hA) (isPosCol_opCol hAp)
      (isHermCol_opCol hB) (isPosCol_opCol hBp) hγ
