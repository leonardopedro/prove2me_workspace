-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_mem_unitary
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

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_mem_unitary (n t : ℝ) : T.approxU n t ∈ unitary (H →L[ℂ] H) := by sorry
