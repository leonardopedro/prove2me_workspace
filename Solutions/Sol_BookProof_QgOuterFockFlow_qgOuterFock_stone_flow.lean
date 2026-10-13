-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.qgOuterFock_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_secN_dom_dense
import Theorems.Thm_BookProof_QgOuterFockFlow_secData_ext_symmetricOn
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato
open BookProof.EsaClosure
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.StoneBridge

noncomputable section

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (U : ℝ → (Sec ι →L[ℂ] Sec ι)),
      IsSelfAdjointExtension (secData W Q).ext T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (secN_dom_dense W Q) (secData_ext_symmetricOn W Q)
      (secHam_essentiallySelfAdjointOn W Q)
