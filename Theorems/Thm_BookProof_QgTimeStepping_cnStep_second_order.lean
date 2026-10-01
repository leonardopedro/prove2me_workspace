-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.cnStep_second_order
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

theorem BookProof.QgTimeStepping.cnStep_second_order {tau : ℝ} (htau : tau ≠ 0) (x : T.domain) (hx : T.op x ∈ T.domain) :
    cnStep T tau (x : H)
      = (x : H) - ((tau : ℂ) * Complex.I) • T.op x
        + ((tau : ℂ) * Complex.I)
            • ((T.res (2 / tau) (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by sorry
