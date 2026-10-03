-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.cnStep_eq_neg_shift
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgTimeStepping.cnStep_eq_neg_shift (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0) (y : H) :
    cnStep T tau y = -(T.shift (-(2 / tau)) (T.res (2 / tau) y)) := by sorry
