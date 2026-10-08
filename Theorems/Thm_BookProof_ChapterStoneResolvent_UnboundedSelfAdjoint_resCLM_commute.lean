-- Generated from ChapterStoneGroup.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.resCLM_commute
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)


theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.resCLM_commute (l m : ℝ) : Commute (T.resCLM l) (T.resCLM m) := by sorry
