-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedNumber_stone_flow
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_graded_stone_flow
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
theorem solution :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock) (T : UnboundedSelfAdjoint GFock)
      (U : ℝ → (GFock →L[ℂ] GFock)),
      IsPositiveSelfAdjointExtension (gradedHamiltonian idCol idCol) A ∧
        T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U := graded_stone_flow isHermCol_idCol isPosCol_idCol isHermCol_idCol isPosCol_idCol
