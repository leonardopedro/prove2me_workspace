-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.cnStep_apply
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgTimeStepping.cnStep_apply (T : UnboundedSelfAdjoint H) (tau : ℝ) (y : H) :
    cnStep T tau y
      = -y - (((2 * (2 / tau) : ℝ) : ℂ) * Complex.I) • ((T.res (2 / tau) y : T.domain) : H) := by sorry
