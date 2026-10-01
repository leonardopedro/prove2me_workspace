-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_iterate_cnStep_sub_stoneU_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgTimeStepping.norm_iterate_cnStep_sub_stoneU_le {tau : ℝ} (htau : 0 < tau) (k : ℕ) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖(cnStep T tau)^[k] (x : H) - T.stoneU ((k : ℝ) * tau) (x : H)‖
      ≤ 2 * (k : ℝ) * tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by sorry
