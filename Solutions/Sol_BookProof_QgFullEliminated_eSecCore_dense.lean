-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eSecCore_dense
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_DirectSumEsa_dsCore_dense
import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense
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
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim
open BookProof.ScalaronEsa

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution :
    Dense ((secCore (ι := EGMode) : Submodule ℂ (Sec EGMode)) : Set (Sec EGMode)) :=
  dsCore_dense fun _ => ccDomain_dense
