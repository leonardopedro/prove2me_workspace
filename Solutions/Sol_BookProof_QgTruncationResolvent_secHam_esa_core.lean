-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.secHam_esa_core
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_QgTruncationResolvent_esa_core_of_ext
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in

theorem solution : EssentiallySelfAdjointOn (secCore (ι := ι)) (secHam W Q) :=
  esa_core_of_ext (secData W Q) (secHam_essentiallySelfAdjointOn W Q)
