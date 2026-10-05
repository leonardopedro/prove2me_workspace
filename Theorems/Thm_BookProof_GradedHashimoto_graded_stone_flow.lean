-- Generated from ChapterGradedHashimoto.lean — theorem BookProof.GradedHashimoto.graded_stone_flow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockSecondQuantization
open BookProof.StoneBridge
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

theorem BookProof.GradedHashimoto.graded_stone_flow {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hbherm : IsHermCol colB) (hbpos : IsPosCol colB)
    (hfherm : IsHermCol colF) (hfpos : IsPosCol colF) :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock) (T : UnboundedSelfAdjoint GFock)
      (U : ℝ → (GFock →L[ℂ] GFock)),
      IsPositiveSelfAdjointExtension (gradedHamiltonian colB colF) A ∧
        T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U := by sorry
