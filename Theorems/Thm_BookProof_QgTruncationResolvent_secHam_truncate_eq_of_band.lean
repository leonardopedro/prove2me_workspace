-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.secHam_truncate_eq_of_band
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa
open BookProof.QgTruncationResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section


theorem BookProof.QgTruncationResolvent.secHam_truncate_eq_of_band (Λ : Set ι) {x : secCore (ι := by sorry
