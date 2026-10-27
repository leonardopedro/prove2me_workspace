-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eCoupling_ne_zero
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (g : ℝ) (hg : g ≠ 0) (k : Mom) :
    eCoupling g ((k, (0, 0)) : EGMode) (k, (0, 0)) ≠ 0 := by

  simp only [eCoupling, eTrace]
  norm_num [hg]
