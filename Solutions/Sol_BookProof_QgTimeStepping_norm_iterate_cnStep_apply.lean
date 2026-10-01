-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_iterate_cnStep_apply
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_norm_cnStep_apply
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0)
    (k : ℕ) (y : H) : ‖(cnStep T tau)^[k] y‖ = ‖y‖ := by

  induction k generalizing y with
  | zero => simp
  | succ k ih =>
      rw [Function.iterate_succ_apply, ih, norm_cnStep_apply T h]
