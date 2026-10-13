-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.secN_dom_dense
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_comparison_dom_dense
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution : Dense (((secN W Q).dom : Submodule ℂ (Sec ι)) : Set (Sec ι)) := comparison_dom_dense _
