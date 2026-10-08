-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.hasDerivAt_approxU
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

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.hasDerivAt_approxU (n t : ℝ) :
    HasDerivAt (fun s : ℝ => T.approxU n s) (T.approxU n t * T.yosidaGen n) t := by sorry
