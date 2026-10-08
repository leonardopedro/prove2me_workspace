-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.exists_domain_two_approx
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



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (T : UnboundedSelfAdjoint H)

theorem BookProof.QgTimeStepping.exists_domain_two_approx (v : H) {eps : ℝ} (heps : 0 < eps) :
    ∃ x : T.domain, T.op x ∈ T.domain ∧ ‖v - (x : H)‖ < eps := by sorry
