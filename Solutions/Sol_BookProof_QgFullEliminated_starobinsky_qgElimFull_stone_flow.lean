-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.starobinsky_qgElimFull_stone_flow
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_qgElimFull_stone_flow
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
    ∃ (T : UnboundedSelfAdjoint (Sec EGMode))
      (U : ℝ → (Sec EGMode →L[ℂ] Sec EGMode)),
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgElimFullModes g)) T.op ∧
        IsStoneFlow T U := qgElimFull_stone_flow (starobinskyWall M alpha halpha) g
