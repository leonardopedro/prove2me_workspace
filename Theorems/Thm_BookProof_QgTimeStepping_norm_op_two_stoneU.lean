-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.norm_op_two_stoneU
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint
open BookProof.QgTimeStepping

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section


theorem BookProof.QgTimeStepping.norm_op_two_stoneU (t : ℝ) (x : T.domain) (hx : T.op x ∈ T.domain) :
    ‖T.op ⟨T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩,
        stoneU_mem_domain_two T t x hx⟩‖
      = ‖T.op ⟨T.op x, hx⟩‖ := by sorry
