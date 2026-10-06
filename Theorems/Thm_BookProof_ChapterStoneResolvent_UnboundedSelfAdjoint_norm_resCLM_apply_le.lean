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


theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le (l : ℝ) (y : H) : ‖T.resCLM l y‖ ≤ (1 / |l|) * ‖y‖ := by sorry
