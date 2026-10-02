-- Generated from ChapterStoneResolvent.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_shift
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (T : UnboundedSelfAdjoint H)
variable [CompleteSpace H]


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport


g hl]
  exact (T.shiftEquiv hl).apply_symm_apply y

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_shift {l : ℝ} (hl : := by sorry
