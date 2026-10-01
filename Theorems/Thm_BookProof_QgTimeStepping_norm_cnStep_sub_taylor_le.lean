-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_cnStep_sub_taylor_le
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgTimeStepping.norm_cnStep_sub_taylor_le {tau : ℝ} (htau : 0 < tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)‖
      ≤ tau ^ 2 / 2 * ‖T.op ⟨T.op x, hx⟩‖ := by sorry
