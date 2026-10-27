-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.cnStep_eq_neg_shift
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_cnStep_apply
import Theorems.Thm_BookProof_QgTimeStepping_two_div_ne_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0) (y : H) :
    cnStep T tau y = -(T.shift (-(2 / tau)) (T.res (2 / tau) y)) := by

  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero h
  have hop := T.op_res hl y
  rw [cnStep_apply, UnboundedSelfAdjoint.shift_apply, hop]
  push_cast
  module
