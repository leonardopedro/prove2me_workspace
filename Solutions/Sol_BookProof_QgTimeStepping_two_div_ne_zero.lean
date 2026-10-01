-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.two_div_ne_zero
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
theorem solution {tau : ℝ} (h : tau ≠ 0) : (2 / tau : ℝ) ≠ 0 := by

  simpa using h
