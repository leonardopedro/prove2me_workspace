-- Generated from ChapterFermionFock.lean — theorem BookProof.FermionFock.dGammaF_hashimoto_selects
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.SmCar
open BookProof.YangMillsFriedrichs
open BookProof.FermionFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

variable {ι : Type*} [DecidableEq ι]

theorem BookProof.FermionFock.dGammaF_hashimoto_selects (ε : ℕ ≃ FConf) {col : ℕ → (ℕ →₀ ℂ)}
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
            A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by sorry
