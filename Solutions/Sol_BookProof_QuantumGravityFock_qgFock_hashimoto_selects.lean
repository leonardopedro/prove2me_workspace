-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgFock_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_FockSecondQuantization_secondQuantization_hashimoto_selects
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (e84 : ℕ ≃ (Fin 84 →₀ ℕ)) (eps : ℕ ≃ BoseConf)
    (A : finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84) →ₗ[ℂ]
      finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84))
    (hA : SymmetricOn (finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84))
      ((finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84)).subtype.comp A))
    (hpos : ∀ x, 0 ≤ quadForm
      ((finiteModeDomain (BookProof.HermiteProductCore.coreBasis e84)).subtype.comp A) x)
    {gamma : ℝ} (hgamma : 0 < gamma) :
    ∃ (Dom : Submodule ℂ BookProof.FockSecondQuantization.Fock)
      (A' : Dom →ₗ[ℂ] BookProof.FockSecondQuantization.Fock)
      (R : BookProof.FockSecondQuantization.Fock →L[ℂ] BookProof.FockSecondQuantization.Fock),
      IsPositiveSelfAdjointExtension
        (dGammaOpB eps (opCol (BookProof.HermiteProductCore.coreBasis e84) A)) A' ∧
        IsShiftInvert A' gamma R ∧ ‖R‖ ≤ gamma⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : BookProof.FockSecondQuantization.Fock,
          Filter.Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN eps) k u)
            Filter.atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : BookProof.FockSecondQuantization.Fock,
          Filter.Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN eps) k) z u)
            Filter.atTop (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ BookProof.FockSecondQuantization.Fock)
          (A'' : Dom' →ₗ[ℂ] BookProof.FockSecondQuantization.Fock),
          IsShiftInvert A'' gamma R →
            Dom' = Dom ∧ ∀ (x : BookProof.FockSecondQuantization.Fock) (hx : x ∈ Dom)
              (hx' : x ∈ Dom'), A'' ⟨x, hx'⟩ = A' ⟨x, hx⟩) :=
  secondQuantization_hashimoto_selects eps (BookProof.HermiteProductCore.coreBasis e84) A hA
      hpos hgamma
