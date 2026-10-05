-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.qgElimFull_number_conserving
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) {num : EGMode → ℕ}
    (hnum : ∀ a b : EGMode, b.1 = a.1 → num b = num a) (x : secCore (ι :=
  secHam_number_conserving W (qgElimFullModes g)
      (fun a b hb => hnum a b (mem_eNbr.mp hb)) x hx a ha
