-- Generated from ChapterStoneResolvent.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.res_comm
import Mathlib
import Definitions.Def_ChapterStoneResolvent
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_op
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
theorem solution {l m : ℝ} (hl : l ≠ 0) (hm : m ≠ 0) (y : H) :
    ((T.res l ((T.res m y : T.domain) : H) : T.domain) : H)
      = ((T.res m ((T.res l y : T.domain) : H) : T.domain) : H) := by

  set a : T.domain := T.res l ((T.res m y : T.domain) : H) with ha
  set b : T.domain := T.res m ((T.res l y : T.domain) : H) with hb
  -- `A a = res_l y + i m a`
  have h1 : T.op a = ((T.res l y : T.domain) : H) + ((m : ℂ) * Complex.I) • (a : H) := by
    have hcomm := T.res_op hl (T.res m y)
    have hAres : T.op (T.res m y) = y + ((m : ℂ) * Complex.I) • ((T.res m y : T.domain) : H) :=
      T.op_res hm y
    rw [hAres] at hcomm
    rw [map_add, map_smul] at hcomm
    simp only [Submodule.coe_add, Submodule.coe_smul] at hcomm
    rw [← hcomm, ← ha]
  -- `A b = res_l y + i m b`
  have h2 : T.op b = ((T.res l y : T.domain) : H) + ((m : ℂ) * Complex.I) • (b : H) :=
    T.op_res hm _
  have hd : T.shift m (a - b) = 0 := by
    rw [map_sub, shift_apply, shift_apply, h1, h2]
    module
  have hzero : a - b = 0 := T.shift_injective hm (by simpa using hd)
  have hab : a = b := sub_eq_zero.mp hzero
  rw [hab]
