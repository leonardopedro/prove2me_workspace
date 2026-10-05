-- Generated from ChapterGradedHashimoto.lean — theorem BookProof.GradedHashimoto.graded_hashimoto_selects
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsGhost
open BookProof.GradedHashimoto



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

theorem BookProof.GradedHashimoto.graded_hashimoto_selects (ε : ℕ ≃ GConf) {colB colF : ℕ → (ℕ →₀ ℂ)}
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
            A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by sorry
