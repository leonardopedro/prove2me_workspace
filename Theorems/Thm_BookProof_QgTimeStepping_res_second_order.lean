-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.res_second_order
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

theorem BookProof.QgTimeStepping.res_second_order {l : ℝ} (hl : l ≠ 0) (x : T.domain) (hx : T.op x ∈ T.domain) :
    ((T.res l (x : H) : T.domain) : H)
      = (Complex.I / (l : ℂ)) • (x : H) + (1 / (l : ℂ) ^ 2) • T.op x
        - (1 / (l : ℂ) ^ 2) • ((T.res l (T.op ⟨T.op x, hx⟩) : T.domain) : H) := by sorry
