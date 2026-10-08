-- Generated from ChapterStoneGroup.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le'
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


theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le_prime {n : ℝ} (y : H) :
    ‖T.resCLM (-n) y‖ ≤ (1 / |n|) * ‖y‖ := by sorry
