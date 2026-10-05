-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eTrace_eq_gTrace
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
theorem solution (x : EGMode) : eTrace x = gTrace (x.1, eIdx x.2.1 x.2.2) := rfl
