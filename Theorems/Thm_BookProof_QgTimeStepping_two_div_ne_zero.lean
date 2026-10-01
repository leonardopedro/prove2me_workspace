-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.two_div_ne_zero
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgTimeStepping.two_div_ne_zero {tau : ℝ} (h : tau ≠ 0) : (2 / tau : ℝ) ≠ 0 := by sorry
