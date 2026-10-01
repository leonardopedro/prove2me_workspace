-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.iterate_cnStep_sub
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

theorem BookProof.QgTimeStepping.iterate_cnStep_sub (T : UnboundedSelfAdjoint H) (tau : ℝ) (k : ℕ) (u w : H) :
    (cnStep T tau)^[k] u - (cnStep T tau)^[k] w = (cnStep T tau)^[k] (u - w) := by sorry
