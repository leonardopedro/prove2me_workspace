-- Generated from ChapterStoneResolvent.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_comm
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


t, inner_smul_right, hsym]
  simp [Complex.conj_I]

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_comm {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : H) :
    ((T.res l ((T.res m y : T.domain) : H) : T.domain) : H)
      = ((T. := by sorry
