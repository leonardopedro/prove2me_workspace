-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_iterate_cnStep_sub_stoneU_le
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

theorem BookProof.QgTimeStepping.norm_iterate_cnStep_sub_stoneU_le {tau : ℝ} (htau : 0 < tau) (k : ℕ) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖(cnStep T tau)^[k] (x : H) - T.stoneU ((k : ℝ) * tau) (x : H)‖
      ≤ 2 * (k : ℝ) * tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by sorry
