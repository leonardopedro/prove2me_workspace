-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.secData_ext_symmetricOn
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    SymmetricOn (secN W Q).dom (secData W Q).ext := (secData W Q).ext_symmetricOn (secHam_symmetricOn W Q)
