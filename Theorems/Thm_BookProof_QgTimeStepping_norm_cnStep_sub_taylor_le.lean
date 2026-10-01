-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_cnStep_sub_taylor_le
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

theorem BookProof.QgTimeStepping.norm_cnStep_sub_taylor_le {tau : ℝ} (htau : 0 < tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)‖
      ≤ tau ^ 2 / 2 * ‖T.op ⟨T.op x, hx⟩‖ := by sorry
