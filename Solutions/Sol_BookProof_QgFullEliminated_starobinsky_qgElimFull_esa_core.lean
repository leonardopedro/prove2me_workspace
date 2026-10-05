-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.starobinsky_qgElimFull_esa_core
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_qgElimFull_esa_core_fl
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (g : ℝ) :
    EssentiallySelfAdjointOn (secCore (ι := qgElimFull_esa_core_fl (starobinskyWall M alpha halpha) g
