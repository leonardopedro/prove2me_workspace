-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.qgElimFull_number_conserving
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution (W : WallPot) (g : ℝ) {num : EGMode → ℕ}
    (hnum : ∀ a b : EGMode, b.1 = a.1 → num b = num a) (x : secCore (ι := EGMode)) {n : ℕ}
    (hx : ∀ a, num a ≠ n → (x : Sec EGMode) a = 0) (a : EGMode) (ha : num a ≠ n) :
    (secHam W (qgElimFullModes g) x : Sec EGMode) a = 0 :=
  secHam_number_conserving W (qgElimFullModes g)
    (fun a b hb => hnum a b (mem_eNbr.mp hb)) x hx a ha

/-! ## 8. Non-vacuity -/
