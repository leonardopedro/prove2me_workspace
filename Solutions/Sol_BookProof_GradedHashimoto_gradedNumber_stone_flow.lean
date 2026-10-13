-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedNumber_stone_flow
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_graded_stone_flow
import Theorems.Thm_BookProof_GradedFriedrichs_isHermCol_idCol
import Theorems.Thm_BookProof_GradedFriedrichs_isPosCol_idCol
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
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
open BookProof.StoneBridge
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsGhost

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock) (T : UnboundedSelfAdjoint GFock)
      (U : ℝ → (GFock →L[ℂ] GFock)),
      IsPositiveSelfAdjointExtension (gradedHamiltonian idCol idCol) A ∧
        T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U := graded_stone_flow isHermCol_idCol isPosCol_idCol isHermCol_idCol isPosCol_idCol
