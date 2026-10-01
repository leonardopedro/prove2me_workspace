-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_iterate_cnStep_apply
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

theorem BookProof.QgTimeStepping.norm_iterate_cnStep_apply (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0)
    (k : ℕ) (y : H) : ‖(cnStep T tau)^[k] y‖ = ‖y‖ := by sorry
