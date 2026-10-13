-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.qgElimFull_stone_flow
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_qgElimFull_esa_core_fl
import Theorems.Thm_BookProof_QgFullEliminated_eSecCore_dense
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_symmetricOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim
open BookProof.EsaClosure
open BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec EGMode))
      (U : ℝ → (Sec EGMode →L[ℂ] Sec EGMode)),
      IsSelfAdjointExtension (secHam W (qgElimFullModes g)) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ eSecCore_dense (secHam_symmetricOn W _)
      (qgElimFull_esa_core_fl W g)
