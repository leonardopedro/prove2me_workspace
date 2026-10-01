-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.iterate_cnStep_sub
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) (tau : ℝ) (k : ℕ) (u w : H) :
    (cnStep T tau)^[k] u - (cnStep T tau)^[k] w = (cnStep T tau)^[k] (u - w) := by

  induction k with
  | zero => simp
  | succ m ih =>
      rw [Function.iterate_succ_apply', Function.iterate_succ_apply',
        Function.iterate_succ_apply', ← map_sub, ih]
