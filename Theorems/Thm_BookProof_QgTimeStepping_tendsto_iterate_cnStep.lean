-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.tendsto_iterate_cnStep
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

theorem BookProof.QgTimeStepping.tendsto_iterate_cnStep {t : ℝ} (ht : 0 < t) (v : H) :
    Tendsto (fun k : ℕ => (cnStep T (t / (k + 1)))^[k + 1] v) atTop
      (𝓝 (T.stoneU t v)) := by sorry
