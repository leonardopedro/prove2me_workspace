-- Generated from ChapterQgTimeStepping.lean — theorem BookProof.QgTimeStepping.stoneU_mem_domain_two
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
open BookProof.QgTimeStepping

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable {ι : Type*}



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.QgTimeStepping.stoneU_mem_domain_two (t : ℝ) (x : T.domain) (hx : T.op x ∈ T.domain) :
    T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩ ∈ T.domain := by sorry
