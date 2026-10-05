-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_iterate_cnStep_apply
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgTruncationResolvent
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterStoneResolvent
open BookProof.QgTimeStepping

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section


theorem BookProof.QgTimeStepping.norm_iterate_cnStep_apply (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0)
    (k : ℕ) (y : H) : ‖(cnStep T tau)^[k] y‖ = ‖y‖ := by sorry
