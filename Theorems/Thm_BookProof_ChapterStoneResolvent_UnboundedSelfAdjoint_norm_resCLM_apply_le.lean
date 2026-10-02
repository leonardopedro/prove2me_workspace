-- Generated from ChapterStoneResolvent.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (T : UnboundedSelfAdjoint H)
variable [CompleteSpace H]


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport


 : H) : T.resCLM l y ∈ T.domain := (T.res l y).2

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le (l : ℝ) ( := by sorry
