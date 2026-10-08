-- Generated from ChapterStoneUnitary.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_surjective
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)


theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_surjective (t : ℝ) : Function.Surjective (T.stoneU t) := by sorry
