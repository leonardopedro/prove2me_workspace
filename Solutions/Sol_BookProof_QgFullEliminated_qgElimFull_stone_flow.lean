-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.qgElimFull_stone_flow
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_qgElimFull_esa_core_fl
import Theorems.Thm_BookProof_QgFullEliminated_eSecCore_dense
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_symmetricOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec EGMode))
      (U : ℝ → (Sec EGMode →L[ℂ] Sec EGMode)),
      IsSelfAdjointExtension (secHam W (qgElimFullModes g)) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ eSecCore_dense (secHam_symmetricOn W _)
      (qgElimFull_esa_core_fl W g)
