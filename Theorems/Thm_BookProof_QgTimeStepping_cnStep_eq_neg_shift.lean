-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.cnStep_eq_neg_shift
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
open BookProof.QgTimeStepping

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable {ι : Type*}



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.QgTimeStepping.cnStep_eq_neg_shift (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0) (y : H) :
    cnStep T tau y = -(T.shift (-(2 / tau)) (T.res (2 / tau) y)) := by sorry
