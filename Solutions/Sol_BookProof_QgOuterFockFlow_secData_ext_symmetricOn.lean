-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.secData_ext_symmetricOn
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_symmetricOn
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_symmetricOn




open Filter Topology
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution :
    SymmetricOn (secN W Q).dom (secData W Q).ext := (secData W Q).ext_symmetricOn (secHam_symmetricOn W Q)
