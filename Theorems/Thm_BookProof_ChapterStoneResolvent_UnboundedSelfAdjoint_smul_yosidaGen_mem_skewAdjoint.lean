-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.smul_yosidaGen_mem_skewAdjoint
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (T : UnboundedSelfAdjoint H)

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.smul_yosidaGen_mem_skewAdjoint (n t : ℝ) :
    t • T.yosidaGen n ∈ skewAdjoint (H →L[ℂ] H) := by sorry
