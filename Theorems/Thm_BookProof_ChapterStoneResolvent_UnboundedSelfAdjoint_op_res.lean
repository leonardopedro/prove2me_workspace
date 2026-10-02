-- Generated from ChapterStoneResolvent.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.op_res
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


g hl]
  exact (T.shiftEquiv hl).symm_apply_apply x

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.op_res {l : ℝ} (hl : l ≠ 0) (y : H) :
    T.op (T.res l y) = y + ((l : := by sorry
