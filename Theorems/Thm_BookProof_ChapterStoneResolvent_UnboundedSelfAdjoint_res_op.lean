-- Generated from ChapterStoneResolvent.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_op
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


‖ ≤ (1 / |l|) * ‖y‖ :=
  T.norm_res_le l y

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_op {l : ℝ} (hl : l ≠ 0) (x : T.domain) :
    ((T.res l := by sorry
