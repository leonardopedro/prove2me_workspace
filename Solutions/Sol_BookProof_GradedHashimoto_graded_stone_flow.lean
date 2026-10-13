-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.graded_stone_flow
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_friedrichs_extension
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_positive
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
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge
open BookProof.FockSecondQuantization
open BookProof.StoneBridge
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsGhost

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hbherm : IsHermCol colB) (hbpos : IsPosCol colB)
    (hfherm : IsHermCol colF) (hfpos : IsPosCol colF) :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock) (T : UnboundedSelfAdjoint GFock)
      (U : ℝ → (GFock →L[ℂ] GFock)),
      IsPositiveSelfAdjointExtension (gradedHamiltonian colB colF) A ∧
        T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := gradedHamiltonian_friedrichs_extension hbherm hbpos hfherm hfpos
  obtain ⟨T, U, hdom, hop, hflow⟩ :=
    exists_stone_flow_of_positive (Hc := gradedHamiltonian colB colF)
      lpFiniteModes_dense hA
  exact ⟨Dom, A, T, U, hA, hdom, hop, hflow⟩
