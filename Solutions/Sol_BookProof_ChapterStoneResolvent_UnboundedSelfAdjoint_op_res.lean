-- Generated from ChapterStoneResolvent.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.op_res
import Mathlib
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint







open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]



variable (T : UnboundedSelfAdjoint H)













variable [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {l : ℝ} (hl : l ≠ 0) (y : H) :
    T.op (T.res l y) = y + ((l : ℂ) * Complex.I) • ((T.res l y : T.domain) : H) := by

  have h := T.shift_res hl y
  rw [shift_apply] at h
  exact sub_eq_iff_eq_add.mp h
