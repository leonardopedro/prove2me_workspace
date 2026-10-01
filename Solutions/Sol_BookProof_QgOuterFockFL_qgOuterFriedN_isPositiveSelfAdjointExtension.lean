-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.qgOuterFriedN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
import Theorems.Thm_BookProof_QgOuterFockFL_qgOuterCore_le_friedDom
import Theorems.Thm_BookProof_QgOuterFockFL_qgOuterFriedN_apply
open BookProof.QgOuterFockFL



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 2000000 in
-- the Friedrichs domain is a range of a completion-built resolvent: defeq checks are costly
theorem solution :
    IsPositiveSelfAdjointExtension qgOuterN qgOuterFriedN :=
  qgOuterComparison.isPositiveSelfAdjointExtension qgOuterN (fun x => by
      refine ⟨qgOuterCore_le_friedDom x.2, ?_⟩
      refine lp.ext (funext fun n => ?_)
      rw [qgOuterFriedN_apply, harmFried_op_core (n * 84) ⟨(x : qgOuterFock) n, x.2.2 n⟩]
      exact (dsOp_coe (fun n : ℕ => harmCore (d := n * 84)) x n).symm)
